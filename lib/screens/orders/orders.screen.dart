import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sieves_courier/providers/order.provider.dart';
import 'package:sieves_courier/constants.dart';
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
  late List<Order> activeOrders;
  late Future fetchOrder;
  @override
  void initState() {
    fetchOrder = Provider.of<OrderProvider>(context, listen: false).fetchOrders();
    activeOrders = Provider.of<OrderProvider>(context, listen: false).activeOrders;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Активные заказы',
                style: primaryHeadTitleStyle
            ),
          ],
        ),
        SizedBox(height: 15),
        Expanded(
          child: FutureBuilder(
            future: fetchOrder,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasError) {
                  return Center(child: Text('has error'),);
                } else {
                  if (activeOrders.length > 0) {
                    return Consumer<OrderProvider>(
                      builder: (ctx, order, child) => ListView.builder(
                        itemCount: order.activeOrders.length,
                        itemBuilder: (ctx, i) => OrderCard(order: order.activeOrders[i]),
                      ),
                    );
                  }
                  return Center(child: Text('список пусто'),);
                }
              }
            },
          )
        )
      ],
    );
  }
}

