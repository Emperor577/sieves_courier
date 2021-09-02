import 'package:flutter/material.dart';
import 'package:sieves_courier/constants.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                    Icons.arrow_back
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
