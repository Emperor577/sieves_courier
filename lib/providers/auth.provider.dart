import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:sieves_courier/services/storage.dart';
import '../constants.dart';
import '../models/http_exception.dart';
import 'package:provider/provider.dart';
import 'package:sieves_courier/providers/order.provider.dart';

final secureStorage = SecureStorage();

class Auth with ChangeNotifier {
  String? _token;
  int? daySessionId;
  var _employee;
  Map<String, dynamic> _authData = {};
  String? _locationPermissionStatus;


  bool get isAuth {
    return _token != null;
  }

  get token {
    return _token;
  }

  Future<bool> get locationPermissionStatus async {
    if (_locationPermissionStatus == null) {
      _locationPermissionStatus = await secureStorage.readData('locationPermissionStatus');
    }
    return Future.value(_locationPermissionStatus != null);
  }

  Future<void> setPermissionStatus() async {
    _locationPermissionStatus = 'true';
    await secureStorage.writeData('locationPermissionStatus', 'true');
    notifyListeners();
  }

  Future<void> setToken(String accessToken) async{
    _token = accessToken;
    await fetchDaySession();
    return Future.value();
  }

  Future<void> fetchDaySession() async {
    final url = API_DOMAIN + '/day-session/0?specialType=current';
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + token
        }
      );

      final decodedResponse = json.decode(response.body);
      daySessionId = decodedResponse['id'];
      return Future.value();
    } catch (error) {
      throw error;
    }
  }

  get authData {
    return _authData;
  }

  Future<void> setAuthData(String sub) async {
    final url = API_DOMAIN + '/identity/0?auth_id=' + sub + '&expand=employee.branch,employee.individual.photo';
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + token
        }
      );
      final decodedResponse = json.decode(response.body);
      _employee = decodedResponse['employee'];
      _authData = {
        "day_session_id": daySessionId,
        "employee": _employee,
        "token": _token
      };
      notifyListeners();
      return Future.value();
    } catch (error) {
      throw error;
    }
  }

  get employee {
    return _employee;
  }

  Future<void> login(String username, String password) async {
    final url = API_DOMAIN + '/waiter-system/app-login?username=$username&password=$password';
    try {
      final http.Response response  = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      // data = responseData['data'];
      _token = responseData['data']['token'];
      _employee = responseData['data']['employee'];
      // day_session_id = responseData['data']['day_session_id'];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateEmployee(Map<String, dynamic> payload) async {
    final url = API_DOMAIN + '/employee/' + _employee['id'].toString();
    try {
      final response = await http.put(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token,
        HttpHeaders.contentTypeHeader: 'application/json'
      },
          body: json.encode(payload)
      );
    } catch (error) {
      throw error;
    }
  }

  void logoutAction() async {
    await secureStorage.deleteData('refresh_token');
    await http.get(
        Uri.parse('https://exodelicainc.eu.auth0.com/v2/logout?client_id=PRrEzFPGkPYdrTorrCF4JxqnySYRarbh'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + token
        }
    );
    _token = null;
    notifyListeners();
  }
}