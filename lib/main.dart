import 'package:flutter/material.dart';
import 'package:sieves_courier/screens/auth/auth.screen.dart';
import 'package:sieves_courier/screens/history/history.screen.dart';
import 'package:sieves_courier/screens/home/home.dart';
import 'package:sieves_courier/screens/orders/orders.screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sieves Courier',
      initialRoute: '/',
      routes: {
        '/': (context) => AuthenticateScreen(),
      },
    );
  }
}