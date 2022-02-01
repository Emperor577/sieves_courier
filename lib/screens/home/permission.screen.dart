import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sieves_courier/services/storage.dart';
import 'package:sieves_courier/providers/auth.provider.dart';
import 'package:provider/provider.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  final SecureStorage storage = SecureStorage();

  @override
  void initState() {
    Future.delayed(Duration.zero, () => showAlert(context));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Text('new'),
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
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
              child: Text('Deny'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await Provider.of<Auth>(context, listen: false).setPermissionStatus();
                  Navigator.of(context).pop();
                },
                child: Text('Accept')
            )
          ],
        )
    );
  }
}

