import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import '../constants.dart';
import 'package:sieves_courier/models/order.model.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders;
  var _data;
  OrderProvider(this._data, this._orders);

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    if (_orders.isEmpty) {
      final url = API_DOMAIN + '/order?orderType=delivery&delivery_employee_id=' + _data['employee']['id'] + '&day_session_id=' + _data['day_session_id'] + '&expand=deliveryEmployee.individual,branch,address,customer.contacts,orderItems.product.inventory,currentStatus,orderStatuses.orderTypeStatus,transactions.paymentType';
      try {
        final response = await http.get(Uri.parse(url), headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + _data['token']
        });
        final responseOrders = json.decode(response.body);
        _orders = responseOrders['models'];
        notifyListeners();
      } catch (error) {
        throw error;
      }
    }
  }
}