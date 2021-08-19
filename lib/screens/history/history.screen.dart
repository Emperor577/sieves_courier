import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sieves_courier/constants.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'История',
            style: TextStyle(
                color: primaryBlueColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 15),
          Card(
            elevation: 3.5,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '№ 3526955421258',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        '2020-10-09  21:12:32',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFB1B1B1)
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 55,
                    height: 20,
                    padding: const EdgeInsets.only(
                      top: 3
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF31C971),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                        'вовремя',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontStyle: FontStyle.normal
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 3.5,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '№ 3526955421258',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        '2020-10-09  21:12:32',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFB1B1B1)
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 55,
                    height: 20,
                    padding: const EdgeInsets.only(
                        top: 3
                    ),
                    decoration: BoxDecoration(
                        color: primaryRedColor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      'поздно',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontStyle: FontStyle.normal
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ]
      )
    );
  }
}
