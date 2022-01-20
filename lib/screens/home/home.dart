import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sieves_courier/constants.dart';
import 'package:sieves_courier/screens/history/history.screen.dart';
import 'package:sieves_courier/screens/orders/orders.screen.dart';
import 'package:sieves_courier/screens/profile/profile.screen.dart';
import 'package:provider/provider.dart';
import 'package:sieves_courier/providers/auth.provider.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart' as permissionHandler;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Location location = new Location();
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
    getCurrentLocation();
    new Timer.periodic(new Duration(minutes: 3), (Timer t) {
      getCurrentLocation();
    });
    super.initState();
  }

  void getCurrentLocation() async {
    bool _serviceEnabled;
    permissionHandler.PermissionStatus permissionStatus;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    permissionStatus = await permissionHandler.Permission.locationWhenInUse.status;
    if (!permissionStatus.isGranted) {
      var permissionStatus = await permissionHandler.Permission.locationWhenInUse.request();
      if (permissionStatus.isGranted) {
        await _showLocationPermissionDialog();
      }
      if(permissionStatus.isPermanentlyDenied){
        //When the user previously rejected the permission and select never ask again
        //Open the screen of settings
        bool res = await permissionHandler.openAppSettings();
      }
    } else{
      //In use is available, check the always in use
      var status = await permissionHandler.Permission.locationAlways.status;
      if(!status.isGranted) {
        await _showLocationPermissionDialog();
      }
    }

    _locationData = await location.getLocation();
    await Provider.of<Auth>(context, listen: false).updateEmployee({"lat": _locationData.latitude, "lng": _locationData.longitude});
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

  Future<void> _showLocationPermissionDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text('Use Your Location'),
          content: Text('Go Delivery collects your location data to enable identification of nearby orders even when the app not in use'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Deny')
            ),
            ElevatedButton(
                onPressed: () {
                  permissionHandler.Permission.locationAlways.request();
                  Navigator.of(context).pop();
                },
                child: Text('Accept')
            )
          ],
        ),
    );
  }
}