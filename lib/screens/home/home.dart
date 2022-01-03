import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sieves_courier/constants.dart';
import 'package:sieves_courier/screens/history/history.screen.dart';
import 'package:sieves_courier/screens/orders/orders.screen.dart';
import 'package:sieves_courier/screens/profile/profile.screen.dart';
import 'package:provider/provider.dart';
import 'package:sieves_courier/providers/auth.provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    OrdersScreen(),
    HistoryScreen(),
    ProfileScreen()
  ];
  final List<Map<String, Object>> pages = [
    {
      'page': OrdersScreen(),
      'title': 'Активные заказы'
    },
    {
      'page' : HistoryScreen(),
      'title' : 'История',
    },
    {
      'page' : ProfileScreen(),
      'title' : 'Профиль'
    }
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    new Timer.periodic(new Duration(minutes: 3), (Timer t) {
      getCurrentLocation();
    });
    super.initState();
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    dynamic permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    await Provider.of<Auth>(context, listen: false).updateEmployee({"lat": position.latitude, "lng": position.longitude});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_selectedIndex]['title'] as String),
      ),
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(0, -1),
              blurRadius: 3,
              spreadRadius: 0
            ),
          ]
        ),
        child: new BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart,),
              label: 'Заказы',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule_outlined,),
              label: 'История',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,),
              label: 'Профиль',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primaryBlueColor,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      )
    );
  }
}