import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sieves_courier/constants.dart';
import 'package:sieves_courier/models/order.model.dart';
import 'package:sieves_courier/widgets/time_difference.widget.dart';
import 'inner-pages/order_detail.screen.dart';
import 'package:sieves_courier/providers/order.provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class OrderCard extends StatefulWidget {
  final Order order;
  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState(order);
}

class _OrderCardState extends State<OrderCard> {
  final Order order;
  _OrderCardState(this.order);

  String getAddress(Map<String, dynamic> address) {
    final district = address['district'];
    final decodedAddress = json.decode(address['address']);
    return district + ', ' + decodedAddress['street'] + ', ' + decodedAddress['house'].toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Card(
      elevation: primaryCardElevation,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderDetailScreen(order: order)),
                );
              },
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/loook.jpeg'),
                    radius: 30.0,
                  ),
                  SizedBox(width: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        order.branch['name'],
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
                        TimeDifference(from: order.created_at),
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
                        InkWell(
                          onTap: () async {
                            if (await canLaunch('tel:' + order.customer['contacts'][0]['phone'])) {
                              String phone = order.customer['contacts'][0]['phone'].toString().contains('+') ?
                              order.customer['contacts'][0]['phone'] : '+' + order.customer['contacts'][0]['phone'];
                              await launch('tel:' + phone);
                            } else {
                              throw 'Could not launch ' + 'tel:' + order.customer['contacts'][0]['phone'];
                            }
                          },
                          child: Text(
                            order.customer['contacts'][0]['phone'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 13
                            ),
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
                      order.transactions[0]['paymentType']['is_cash'] == 1 ? Icons.request_quote : Icons.payment_outlined,
                      color: Color(0xFF949494),
                    ),
                    SizedBox(width: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          order.transactions[0]['paymentType']['name'],
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
                SizedBox(height: 22,),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Color(0xFF949494),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    getAddress(order.address),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Адрес',
                            style: TextStyle(
                                color: Color(0xFF949494),
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
