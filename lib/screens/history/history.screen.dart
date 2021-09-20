import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sieves_courier/constants.dart';
import 'package:provider/provider.dart';
import 'package:sieves_courier/models/order.model.dart';
import 'package:sieves_courier/providers/order.provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({ Key? key }) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

List<Map<String, dynamic>> generateItems(List<Order> orders) {
  return List<Map<String, dynamic>>.generate(orders.length, (index) {
    return {
      "id": orders[index].id,
      "isExpanded": false,
      "order": orders[index]
    };
  });
}

class _HistoryScreenState extends State<HistoryScreen> {

  bool checkDifference(String startTime, String endTime, int checkPointMinute) {
    DateTime createdAt = DateTime.parse(startTime).add(Duration(hours: 5));
    DateTime deliveredTime = DateTime.parse(endTime);
    Duration difference = deliveredTime.difference(createdAt);
    if (difference.inHours > 0) {
      return false;
    }
    return difference.inMinutes < checkPointMinute;
  }

  @override
  Widget build(BuildContext context) {
    List<Order> deliveredOrders = Provider.of<OrderProvider>(context).deliveredOrders;
    List<Map<String, dynamic>> _historyItems = generateItems(deliveredOrders);
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: size.width,
      height: size.height,
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
          Expanded(
            child: _historyItems.length == 0 ?
              Center(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.announcement_outlined
                    ),
                    Text('Пусто')
                  ],
                ),
              ) :
              ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10,);
                },
                itemCount: _historyItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: primaryCardElevation,
                    child: ExpansionTile(
                      title: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    '№ ' + _historyItems[index]['order'].receipt_number.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    _historyItems[index]['order'].delivery_time.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFB1B1B1)
                                    ),
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              Container(
                                width: 55,
                                height: 20,
                                padding: const EdgeInsets.only(
                                    top: 3
                                ),
                                decoration: BoxDecoration(
                                    color: checkDifference(
                                        _historyItems[index]['order'].created_at,
                                        _historyItems[index]['order'].delivery_time,
                                        50
                                    ) ?
                                    Color(0xFF31C971) : primaryRedColor,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Text(
                                  checkDifference(
                                      _historyItems[index]['order'].created_at,
                                      _historyItems[index]['order'].delivery_time,
                                      50
                                  ) ? 'вовремя' : 'поздно',
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
                      children: <Widget>[
                        Container(
                          width: size.width,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(20.0),
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
                                          _historyItems[index]['order'].branch['name'],
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
                                            Text(_historyItems[index]['order'].delivery_time.toString()),
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
                                              _historyItems[index]['order'].customer['contacts'][0]['phone'],
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
                                          _historyItems[index]['order'].transactions[0]['paymentType']['is_cash'] == 1 ? Icons.request_quote : Icons.payment_outlined,
                                          color: Color(0xFF949494),
                                        ),
                                        SizedBox(width: 30,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              _historyItems[index]['order'].transactions[0]['paymentType']['name'],
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
                        )
                      ],
                    ),
                  );
                }
              ),
          ),
        ]
      )
    );
  }
}