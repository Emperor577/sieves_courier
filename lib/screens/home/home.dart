import 'package:flutter/material.dart';
import 'package:sieves_courier/constants.dart';
import 'package:sieves_courier/screens/history/history.screen.dart';
import 'package:sieves_courier/screens/orders/orders.screen.dart';
import 'package:flutter/services.dart';
import 'package:sieves_courier/screens/profile/profile.screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    OrdersScreen(),
    HistoryScreen(),
    ProfileScreen()
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: new BottomNavigationBar(
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
      )
    );
  }
}