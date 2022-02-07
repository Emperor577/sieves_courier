import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sieves_courier/providers/auth.provider.dart';
import 'package:sieves_courier/providers/order.provider.dart';
import 'package:sieves_courier/screens/auth/auth.screen.dart';
import 'package:sieves_courier/screens/auth/auth_by_auth0.screen.dart';
import 'package:sieves_courier/screens/history/history.screen.dart';
import 'package:sieves_courier/screens/home/home.dart';
import 'package:sieves_courier/screens/home/permission.screen.dart';
import 'package:sieves_courier/screens/orders/orders.screen.dart';
import 'package:sieves_courier/screens/profile/inner-pages/delivery-analytics.screen.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  // await GetStorage.init();
  runApp(MyApp());
}

// TODO add order success rate
// TODO remove storage in ios after logout or delete app
// TODO change login part screen


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, OrderProvider>(
          create: (ctx) => OrderProvider({}, []),
          update: (context, auth, previous) => OrderProvider(
              auth.authData,
              previous == null ? [] : previous.orders
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sieves Courier',
          home: FutureBuilder(builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState.index != 3) {
               return CircularProgressIndicator();
              } else {
                if (snapshot.hasData && snapshot.data != null && snapshot.data == true) {
                  return auth.isAuth ? HomeScreen() : AuthByAuth0Screen();
                }
                else {
                  return PermissionScreen();
                }
              }
            },
            future: auth.locationPermissionStatus,
          ),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            DeliveryAnalyticsScreen.routeName: (ctx) => DeliveryAnalyticsScreen(),
            AuthByAuth0Screen.routeName: (ctx) => AuthByAuth0Screen(),
          },
        ),
      ),
    );
  }
}
