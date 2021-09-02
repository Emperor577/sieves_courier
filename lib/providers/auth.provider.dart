import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/http_exception.dart';



class Auth with ChangeNotifier {
  String _token = '';
  var day_session_id;
  var _employee;
  var data;

  bool get isAuth {
    return _token.isNotEmpty;
  }

  get employee {
    return _employee;
  }

  String get token {
    return _token;
  }

  Future<void> login(String username, String password) async {
    final url = API_DOMAIN + '/waiter-system/app-login?username=$username&password=$password';
    try {
      final http.Response response  = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      data = responseData['data'];
      _token = responseData['data']['token'];
      _employee = responseData['data']['employee'];
      day_session_id = responseData['data']['day_session_id'];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}