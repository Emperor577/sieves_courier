import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sieves_courier/providers/order.provider.dart';
import 'package:sieves_courier/constants.dart';
import 'package:sieves_courier/screens/orders/inner-pages/order_detail.screen.dart';
import 'package:sieves_courier/models/order.model.dart';
import 'package:sieves_courier/screens/orders/order_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20
      ),
      child: OrderList(),
    );
  }
}

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  Timer _timer = Timer.periodic(new Duration(seconds: 1), (timer) {});
  int _indicatorCounter = 0;

  @override
  void initState() {
    if (_indicatorCounter <= 3) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _indicatorCounter++;
        });
      });
    } else {
      _timer.cancel();
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Order> activeOrders = Provider.of<OrderProvider>(context).activeOrders;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'Активные заказы',
                style: primaryHeadTitleStyle
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  Provider.of<OrderProvider>(context, listen: false).fetchOrders();
                  _indicatorCounter = 0;
                });
              },
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        SizedBox(height: 15),
        Expanded(
          child: activeOrders.length == 0 ?
            Center(
              child: _indicatorCounter <= 3 ? CircularProgressIndicator() : Text('Список пуст'),
            ) :
            ListView.builder(
              itemCount: activeOrders.length,
              itemBuilder: (context, i) => OrderCard(order: activeOrders[i]),
            ),
        )
      ],
    );
  }
}

