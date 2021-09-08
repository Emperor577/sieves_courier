import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sieves_courier/constants.dart';


class TimeDifference extends StatefulWidget {
  final String from;
  TimeDifference({Key? key, required this.from}) : super(key: key);

  @override
  _TimeDifferenceState createState() => _TimeDifferenceState(from);
}

class _TimeDifferenceState extends State<TimeDifference> {
  _TimeDifferenceState(this.from);
  final String from;
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

  bool checkTimeout(String from) {
    final DateTime createdAt = DateTime.parse(from).add(new Duration(hours: 5));
    final Duration _time = DateTime.now().difference(createdAt);
    if (_time.inHours == 0) {
      if (_time.inMinutes >= 50) {
        return false;
      }
      return true;
    }
    return false;
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
          color: checkTimeout(from) ? Colors.black : primaryRedColor,
          fontWeight: FontWeight.w600,
          fontSize: 13
      ),
    );
  }
}
