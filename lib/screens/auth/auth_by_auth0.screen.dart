import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:provider/provider.dart';
import 'package:sieves_courier/providers/auth.provider.dart';
import 'package:sieves_courier/services/storage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final SecureStorage secureStorage = SecureStorage();
/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------
const AUTH0_DOMAIN = 'exodelicainc.eu.auth0.com';
const AUTH0_CLIENT_ID = 'FSESux5wUbCU0mivNN5OBsCPtJObbTuJ';

const AUTH0_REDIRECT_URI = 'uz.go.delivery://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

/// -----------------------------------
///                 App
/// ----------------------------------

class AuthByAuth0Screen extends StatefulWidget {
  const AuthByAuth0Screen({Key? key}) : super(key: key);

  @override
  _AuthByAuth0ScreenState createState() => _AuthByAuth0ScreenState();
}

/// -----------------------------------
///              App State
/// -----------------------------------

class _AuthByAuth0ScreenState extends State<AuthByAuth0Screen> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String? errorMessage;

  @override
  void initState() {
    initAction();
    super.initState();
  }

  void initAction() async {
    try {
      final refreshToken = await secureStorage.readData('refresh_token');
    } catch (error) {
      await secureStorage.writeData('refresh_token', 'null');
    }
    // loginAction();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Delivery Authenticate',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Authenticate by Go Delivery'),
        ),
        body: Center(
          child: isBusy
              ? CircularProgressIndicator()
              : ElevatedButton(
                onPressed: () {
                  loginAction();
                },
                child: Text('Login'),
              ),
        ),
      ),
    );
  }

  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<List<String>> getPromtValue() async {
    final storedRefreshToken = await secureStorage.readData('refresh_token');
    return [];
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });
    try {
      final AuthorizationTokenResponse? result =
      await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AUTH0_CLIENT_ID,
          AUTH0_REDIRECT_URI,
          issuer: 'https://$AUTH0_DOMAIN',
          scopes: ['openid', 'profile', 'api', 'email'],
          additionalParameters: {
            'audience': 'localhost:8080/loook-api/web'
          },
          promptValues: await getPromtValue()
        ),
      );
      final idToken = parseIdToken(result!.idToken.toString());
      await Provider.of<Auth>(context, listen: false).setToken(result.accessToken.toString());
      await Provider.of<Auth>(context, listen: false).setAuthData(idToken);
      // TODO encrypt token name
      await secureStorage.writeData('refresh_token', result.accessToken.toString());
    } catch (e, s) {
      print('login error: $e - stack: $s');
      setState(() {
        isBusy = false;
        errorMessage = e.toString();
      });
    }
  }
}
