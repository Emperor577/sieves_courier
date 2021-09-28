import 'package:flutter/material.dart';
import 'package:sieves_courier/constants.dart';
import 'package:sieves_courier/screens/profile/inner-pages/delivery-analytics.screen.dart';
import '../../providers/auth.provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final employee = Provider.of<Auth>(context).employee;
    final photo = employee['individual']['photo'];
    final networkImageUrl = photo == null ?
      profileDefaultImageUrl
      : SPACE_URL + '/' + photo['thumbnail'] + '/' + photo['name'] + '.' + photo['format'];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: primaryCardElevation,
            child: Container(
              width: size.width,
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      networkImageUrl,
                    ),
                    radius: 40.0,
                  ),
                  SizedBox(width: 30,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          employee['individual']['first_name'] + ' ' + employee['individual']['last_name'],
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
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DeliveryAnalyticsScreen.routeName
                );
              },
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
          GestureDetector(
            onTap: () {
              Provider.of<Auth>(context, listen: false).logoutAction();
            },
            child: Card(
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
          ),
        ],
      ),
    );
  }
}
