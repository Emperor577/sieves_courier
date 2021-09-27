import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sieves_courier/providers/auth.provider.dart';
import '../constants.dart';
import 'package:sieves_courier/models/order.model.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> _activeOrders = [];
  List<Order> _deliveredOrders = [];
  Map<String, dynamic> _data;

  OrderProvider(this._data, this._orders);

  List<Order> get orders {
    return [..._orders];
  }

  List<Order> get activeOrders {
    return [..._activeOrders];
  }

  List<Order> get deliveredOrders {
    return [..._deliveredOrders];
  }

  Future<void> fetchOrders() async {
    if (_data.isNotEmpty) {
      final url = API_DOMAIN +
          '/order?orderType=delivery&delivery_employee_id=' +
          _data['employee']['id'].toString() +
          '&day_session_id=' +
          _data['day_session_id'].toString() +
          '&expand=deliveryEmployee.individual,branch,address,customer.contacts,orderItems.product.inventory,currentStatus,orderStatuses.orderTypeStatus,transactions.paymentType';
      try {
        final response = await http.get(Uri.parse(url), headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + _data['token']
        });
        final responseOrders = json.decode(response.body)['models'];
        _orders = [];
        responseOrders.forEach((order) {
          _orders.add(Order(
              id: order['id'] as int,
              branch_id: order['branch_id'] as int,
              day_session_id: order['day_session_id'] as int,
              pos_id: order['pos_id'] as int,
              pos_session_id: order['pos_session_id'] as int,
              order_type_id: order['order_type_id'] as int,
              customer_id: order['customer_id'] as int,
              address_id: order['address_id'] as int,
              value: double.parse(order['value'].toString()),
              paid: double.parse(order['paid'].toString()),
              delivery_employee_id: order['delivery_employee_id'] as int,
              current_status_id: order['current_status_id'] as int,
              deliveryEmployee: order['deliveryEmployee'] as Map<String, dynamic>,
              change: double.parse(order['change'].toString()),
              note: order['note'] == null ? null : order['note'] as String,
              start_time: order['start_time'] as String,
              deadline: order['deadline'] as String,
              delivery_time: order['delivery_time'] as String,
              document_number: order['document_number'] as String,
              receipt_number: order['receipt_number'] as String,
              pager_number: order['pager_number'] as String,
              break_employee_id: order['break_employee_id'] == null ? null : order['break_employee_id'] as int,
              break_photo_id: order['break_photo_id'] == null ? null : order['break_photo_id'] as int,
              customer: order['customer'] as Map<String, dynamic>,
              orderItems: order['orderItems'] as List<dynamic>,
              transactions: order['transactions'] as List<dynamic>,
              currentStatus: order['currentStatus'] as Map<String, dynamic>,
              branch: order['branch'] as Map<String, dynamic>,
              orderStatuses: order['orderStatuses'] as List<dynamic>,
              created_hour: order['created_hour'] == null ? null : order['created_hour'] as String,
              employee_id: order['employee_id'] as int,
              order_type_group_id: order['order_type_group_id'] as int,
              customer_quantity: order['customer_quantity'] as int,
              created_at: order['created_at'] as String,
              address: order['address'] as Map<String, dynamic>,
              counter: order['counter'] as Map<String, dynamic>
          ));
        });
        _activeOrders = [];
        _deliveredOrders = [];
        _orders.forEach((order) {
          if (order.currentStatus['type'] == 'finish') {
            _activeOrders.add(order);
          }
          if (order.currentStatus['type'] == 'delivered') {
            _deliveredOrders.add(order);
          }
        });
        notifyListeners();
      } catch (error) {
        throw error;
      }
    }
  }

  bool checkTimeout(String from) {
    final DateTime createdAt = DateTime.parse(from).add(new Duration(hours: 5));
    final Duration _time = DateTime.now().difference(createdAt);
    if (_time.inHours == 0) {
      if (_time.inMinutes >= 50) {
        return false;
      }
      return true;
    }
    return false;
  }

  Future<void> closeOrder(Order order) async {
    final url = API_DOMAIN + '/order/' + order.id.toString() + '?updateStatus=1';
    order.delivery_time = DateTime.now().subtract(Duration(hours: 5)).toString().substring(0, 19);
    try {
      final response = await http.put(Uri.parse(url), headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + _data['token'],
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: json.encode(order.toJson())
      );
      fetchOrders();
    } catch (error) {
      throw error;
    }
  }
}
