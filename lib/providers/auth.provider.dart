import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/http_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sieves_courier/providers/order.provider.dart';
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

class Auth with ChangeNotifier {
  String? _token;
  int? daySessionId;
  var _employee;
  Map<String, dynamic> _authData = {};

  bool get isAuth {
    return _token != null;
  }

  get token {
    return _token;
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

  void setAuthData(Map<String, dynamic> data) async {
    final url = API_DOMAIN + '/identity/0?auth_id=' + data['sub'] + '&expand=employee.branch,employee.individual.photo';
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

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    _token = null;
    notifyListeners();
  }
}