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
  final String? delivery_time;
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
}
