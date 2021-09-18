import 'package:flutter/material.dart';
import 'package:sieves_courier/models/order_item.model.dart';

class OrderItemComponent extends StatelessWidget {
  final Map<String, dynamic> item;

  const OrderItemComponent({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.only(
        bottom: 12
      ),
      child: Row(
        children: <Widget>[
          Text(
              item['quantity'].toString() + 'x  ' + item['product']['name'] + '  ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Text(
              '  ' + item['total_price'].toString(),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600
            ),
          )
        ],
      ),
    );
  }
}
