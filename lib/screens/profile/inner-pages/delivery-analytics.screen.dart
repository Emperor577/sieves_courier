import 'package:flutter/material.dart';
import 'package:sieves_courier/constants.dart';
import 'package:provider/provider.dart';
import 'package:sieves_courier/providers/order.provider.dart';
import 'package:intl/intl.dart';


class DeliveryAnalyticsScreen extends StatefulWidget {
  const DeliveryAnalyticsScreen({Key? key}) : super(key: key);
  static const routeName = '/delivery-analytics';

  @override
  _DeliveryAnalyticsScreenState createState() => _DeliveryAnalyticsScreenState();
}

class _DeliveryAnalyticsScreenState extends State<DeliveryAnalyticsScreen> {
  bool isLoading = true;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<OrderProvider>(context, listen: false).calculateDeliveryAnalytics().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, dynamic> analytics = Provider.of<OrderProvider>(context, listen: false).analyticsDelivery;
    NumberFormat numberFormat = NumberFormat.currency(locale: 'uz_UZS', decimalDigits: 0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Аналитика доставки'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            padding: const EdgeInsets.all(20),
            child: isLoading ? Center(
              child: CircularProgressIndicator(),
            ) :
            Card(
              elevation: primaryCardElevation,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.shopping_cart,
                            color: Color(0xFF949494),
                          ),
                          SizedBox(width: 30,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                numberFormat.format(analytics['total']),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                'Итого сумма',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF979797)
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(thickness: 1.2,),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.request_quote,
                                color: Color(0xFF949494),
                              ),
                              SizedBox(width: 30,),
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Наличные',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    'Тип оплаты',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryGreyColor
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Text(
                                  numberFormat.format(analytics['cash']),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    'Тип оплаты',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryGreyColor
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Text(
                                  numberFormat.format(analytics['card']),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                  ),
                                  textAlign: TextAlign.end,
                                ),
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
          ),
        ),
      ),
    );
  }
}
