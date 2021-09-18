import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sieves_courier/constants.dart';
import 'package:provider/provider.dart';
import 'package:sieves_courier/providers/order.provider.dart';

class TimeDifference extends StatefulWidget {
  final String from;
  final double fontSize;
  final Color fontColor;
  TimeDifference({required this.from, this.fontSize = 13, this.fontColor = Colors.black});

  @override
  _TimeDifferenceState createState() => _TimeDifferenceState(from, fontSize, fontColor);
}

class _TimeDifferenceState extends State<TimeDifference> {
  _TimeDifferenceState(this.from, this.fontSize, this.fontColor);
  final String from;
  final double fontSize;
  final Color fontColor;
  Timer _timer = Timer.periodic(new Duration(seconds: 1), (timer) {});
  Duration _difference = DateTime.now().difference(DateTime.now());

  @override
  void initState() {
    _timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      final createdAt = DateTime.parse(from).add(new Duration(hours: 5));
      setState(() {
        _difference = DateTime.now().difference(createdAt);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String getDifference() {
    if(_difference.inHours > 9) {
      return _difference.toString().substring(0, 8);
    }
    return ('0' + _difference.toString()).substring(0, 8);
  }


  @override
  Widget build(BuildContext context) {
    return Text(
      _difference.inSeconds != 0 ? getDifference() : 'calculating...',
      style: TextStyle(
          color: Provider.of<OrderProvider>(context).checkTimeout(from) ? fontColor : primaryRedColor,
          fontWeight: FontWeight.w600,
          fontSize: fontSize
      ),
    );
  }
}
