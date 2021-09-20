import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sieves_courier/providers/auth.provider.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------
const AUTH0_DOMAIN = 'exodelicainc.eu.auth0.com';
const AUTH0_CLIENT_ID = 'PRrEzFPGkPYdrTorrCF4JxqnySYRarbh';

const AUTH0_REDIRECT_URI = 'com.example.sievescourier://login-callback';
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
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    print('storedRefreshToken');
    print(storedRefreshToken);
    if (storedRefreshToken == null) return;

    setState(() {
      isBusy = true;
    });

    try {
      final response = await appAuth.token(TokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken,
      ));

      final idToken = parseIdToken(response!.idToken.toString());
      secureStorage.write(key: 'refresh_token', value: response.refreshToken);
      Provider.of<Auth>(context, listen: false).setToken(response.accessToken.toString());
      Provider.of<Auth>(context, listen: false).setAuthData(idToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
      });
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authenticate by Auth0',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Authenticate by Auth0'),
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
          scopes: ['openid', 'profile', 'offline_access', 'api', 'email'],
          additionalParameters: {
            'audience': 'localhost:8080/loook-api/web'
          },
          promptValues: ['login']
        ),
      );

      final idToken = parseIdToken(result!.idToken.toString());
      await secureStorage.write(key: 'refresh_token', value: result.refreshToken);
      Provider.of<Auth>(context, listen: false).setToken(result.accessToken.toString());
      Provider.of<Auth>(context, listen: false).setAuthData(idToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
      });
    } catch (e, s) {
      print('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }
}
