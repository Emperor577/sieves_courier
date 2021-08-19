import 'package:flutter/material.dart';
import 'package:sieves_courier/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Профиль',
            style: primaryHeadTitleStyle
          ),
          SizedBox(height: 15,),
          Card(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://st4.depositphotos.com/4329009/19956/v/380/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg',
                    ),
                    radius: 40.0,
                  ),
                  SizedBox(width: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Cameron Williamson',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Доставщик',
                        style: TextStyle(
                          color: primaryBlueColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
