import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sieves_courier/providers/auth.provider.dart';
import 'package:sieves_courier/providers/order.provider.dart';
import 'package:sieves_courier/screens/auth/auth.screen.dart';
import 'package:sieves_courier/screens/auth/auth_webview.screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, OrderProvider>(
          create: (ctx) => OrderProvider(0, []),
          update: (context, auth, previous) => OrderProvider(
              auth.data,
              previous == null ? [] : previous.orders
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Sieves Courier',
          home: auth.isAuth ? HomeScreen() : AuthWebViewScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen()
          },
        ),
      ),
    );
  }
}
