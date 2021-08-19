import 'package:flutter/material.dart';
import 'package:sieves_courier/constants.dart';


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Активные заказы',
            style: primaryHeadTitleStyle
          ),
          SizedBox(height: 15),
          Card(
            elevation: primaryCardElevation,
            child: Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://toppng.com/uploads/preview/kfc-is-the-popular-fried-chicken-savouring-joint-that-kfc-logo-11563906943d5egjqipew.png'),
                          radius: 30.0,
                        ),
                        SizedBox(width: 30,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'LOOOK Беруний',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                color: Colors.black
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Ресторан',
                              style: TextStyle(
                                color: Color(0xFFB1B1B1),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.2,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                      left: 25,
                      right: 25
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time_filled_outlined,
                              color: Color(0xFF949494),
                            ),
                            SizedBox(width: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '00:58:56',
                                  style: TextStyle(
                                    color: true ? Colors.black : primaryRedColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Потерянные время',
                                  style: TextStyle(
                                    color: Color(0xFF949494),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 22,),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.phone_outlined,
                              color: Color(0xFF949494),
                            ),
                            SizedBox(width: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '998 97 434 43 06',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Номер клиента',
                                  style: TextStyle(
                                      color: Color(0xFF949494),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 22,),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.payment_outlined,
                              color: Color(0xFF949494),
                            ),
                            SizedBox(width: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Пластиковая карта',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Тип оплаты',
                                  style: TextStyle(
                                      color: Color(0xFF949494),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
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
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://toppng.com/uploads/preview/kfc-is-the-popular-fried-chicken-savouring-joint-that-kfc-logo-11563906943d5egjqipew.png'),
                          radius: 30.0,
                        ),
                        SizedBox(width: 30,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'LOOOK Беруний',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  color: Colors.black
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Ресторан',
                              style: TextStyle(
                                color: Color(0xFFB1B1B1),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.2,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                        left: 25,
                        right: 25
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time_filled_outlined,
                              color: Color(0xFF949494),
                            ),
                            SizedBox(width: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '00:58:56',
                                  style: TextStyle(
                                      color: false ? Colors.black : primaryRedColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Потерянные время',
                                  style: TextStyle(
                                      color: Color(0xFF949494),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 22,),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.phone_outlined,
                              color: Color(0xFF949494),
                            ),
                            SizedBox(width: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '998 97 434 43 06',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Номер клиента',
                                  style: TextStyle(
                                      color: Color(0xFF949494),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 22,),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.payment_outlined,
                              color: Color(0xFF949494),
                            ),
                            SizedBox(width: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Пластиковая карта',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Тип оплаты',
                                  style: TextStyle(
                                      color: Color(0xFF949494),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
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
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://toppng.com/uploads/preview/kfc-is-the-popular-fried-chicken-savouring-joint-that-kfc-logo-11563906943d5egjqipew.png'),
                          radius: 30.0,
                        ),
                        SizedBox(width: 30,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'LOOOK Беруний',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  color: Colors.black
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Ресторан',
                              style: TextStyle(
                                color: Color(0xFFB1B1B1),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.2,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                        left: 25,
                        right: 25
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time_filled_outlined,
                              color: Color(0xFF949494),
                            ),
                            SizedBox(width: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '00:58:56',
                                  style: TextStyle(
                                      color: false ? Colors.black : primaryRedColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Потерянные время',
                                  style: TextStyle(
                                      color: Color(0xFF949494),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 22,),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.phone_outlined,
                              color: Color(0xFF949494),
                            ),
                            SizedBox(width: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '998 97 434 43 06',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Номер клиента',
                                  style: TextStyle(
                                      color: Color(0xFF949494),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 22,),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.payment_outlined,
                              color: Color(0xFF949494),
                            ),
                            SizedBox(width: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Пластиковая карта',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Тип оплаты',
                                  style: TextStyle(
                                      color: Color(0xFF949494),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
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
