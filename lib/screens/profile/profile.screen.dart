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
            elevation: primaryCardElevation,
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
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '4.0',
                            style: TextStyle(
                              color: primaryGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(width: 10,),
                          Icon(
                            Icons.star,
                            color: primaryBlueColor,
                          ),
                          Icon(
                            Icons.star,
                            color: primaryBlueColor,
                          ),
                          Icon(
                            Icons.star,
                            color: primaryBlueColor,
                          ),
                          Icon(
                            Icons.star,
                            color: primaryBlueColor,
                          ),
                          Icon(
                            Icons.star,
                            color: primaryGreyColor,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Card(
            elevation: primaryCardElevation,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: new Row(
                children: <Widget>[
                  Icon(
                    Icons.insert_invitation,
                    color: primaryGreyColor,
                  ),
                  SizedBox(width: 30,),
                  Text(
                    'Посещаемость',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          Card(
            elevation: primaryCardElevation,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: new Row(
                children: <Widget>[
                  Icon(
                    Icons.request_page,
                    color: primaryGreyColor,
                  ),
                  SizedBox(width: 30,),
                  Text(
                    'Предоплата',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          Card(
            elevation: primaryCardElevation,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: new Row(
                children: <Widget>[
                  Icon(
                    Icons.directions_car,
                    color: primaryGreyColor,
                  ),
                  SizedBox(width: 30,),
                  Text(
                    'Аналитика Доставки',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Card(
            elevation: primaryCardElevation,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: new Row(
                children: <Widget>[
                  Icon(
                    Icons.https,
                    color: primaryGreyColor,
                  ),
                  SizedBox(width: 30,),
                  Text(
                    'Установить пин-код',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          Card(
            elevation: primaryCardElevation,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: new Row(
                children: <Widget>[
                  Icon(
                    Icons.nightlight_round_outlined,
                    color: primaryGreyColor,
                  ),
                  SizedBox(width: 30,),
                  Text(
                    'Темный режим',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          Card(
            elevation: primaryCardElevation,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: new Row(
                children: <Widget>[
                  Icon(
                    Icons.power_settings_new,
                    color: primaryGreyColor,
                  ),
                  SizedBox(width: 30,),
                  Text(
                    'Выйти',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
