import 'package:sieves_courier/models/branch.model.dart';
import 'package:sieves_courier/models/order_item.model.dart';

class Order {
  final int id;
  final int branch_id;
  final int day_session_id;
  final int employee_id;
  final int? break_employee_id;
  final int? break_photo_id;
  final int? delivery_employee_id;
  final int pos_id;
  final int pos_session_id;
  final int order_type_id;
  final int? order_type_group_id;
  final int? current_status_id;
  final int? customer_id;
  final int? address_id;
  final double? value;
  final double? paid;
  final double? change;
  final String? note;
  final String? start_time;
  final String? deadline;
  String? delivery_time;
  final String? document_number;
  final String? receipt_number;
  final String? pager_number;
  final int? customer_quantity;
  final String? created_hour;
  final String created_at;
  final Map<String, dynamic> counter;
  final List<dynamic> transactions;
  final Map<String, dynamic> branch;
  final List<dynamic> orderItems;
  final List<dynamic> orderStatuses;
  final Map<String, dynamic> currentStatus;
  final Map<String, dynamic> customer;
  final Map<String, dynamic> deliveryEmployee;
  final Map<String, dynamic> address;

  Order({
    required this.id,
    required this.branch_id,
    required this.day_session_id,
    required this.pos_id,
    required this.pos_session_id,
    required this.order_type_id,
    this.customer_id,
    this.address_id,
    this.value,
    this.paid,
    this.delivery_employee_id,
    this.current_status_id,
    required this.deliveryEmployee,
    this.change,
    this.note,
    this.start_time,
    this.deadline,
    this.delivery_time,
    this.document_number,
    this.receipt_number,
    this.pager_number,
    this.break_employee_id,
    this.break_photo_id,
    required this.customer,
    required this.orderItems,
    required this.transactions,
    required this.currentStatus,
    required this.branch,
    required this.orderStatuses,
    this.created_hour,
    required this.employee_id,
    this.order_type_group_id,
    this.customer_quantity,
    required this.created_at,
    required this.address,
    required this.counter,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "branch_id": this.branch_id,
      "day_session_id": this.day_session_id,
      "pos_id": this.pos_id,
      "pos_session_id": this.pos_session_id,
      "order_type_id": order_type_id,
      "customer_id": this.customer_id,
      "address_id": this.address_id,
      "value": this.value,
      "paid": this.paid,
      "delivery_employee_id": this.delivery_employee_id,
      "current_status_id": this.current_status_id,
      "deliveryEmployee": this.deliveryEmployee,
      "change": this.change,
      "note": this.note,
      "start_time": this.start_time,
      "deadline": this.deadline,
      "delivery_time": this.delivery_time,
      "document_number": this.document_number,
      "receipt_number": this.receipt_number,
      "pager_number": this.pager_number,
      "break_employee_id": this.break_employee_id,
      "break_photo_id": this.break_photo_id,
      "customer": this.customer,
      "orderItems": this.orderItems,
      "transactions": this.transactions,
      "currentStatus": this.currentStatus,
      "branch": this.branch,
      "orderStatuses": this.orderStatuses,
      "created_hour": this.created_hour,
      "employee_id": this.employee_id,
      "order_type_group_id": this.order_type_group_id,
      "customer_quantity": this.customer_quantity,
      "created_at": this.created_at,
      "address": this.address,
      "counter": this.counter
    };
  }
}
