import 'package:flutter/material.dart';

class AuthenticateScreen extends StatelessWidget {
  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        child: Column(
          children: <Widget>[
            Text('Добро пожаловать')
          ],
        ),
      ),
    );
  }
}
