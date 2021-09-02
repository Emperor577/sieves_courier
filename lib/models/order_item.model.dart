import 'package:sieves_courier/models/product.model.dart';

class OrderItem {
  final int id;
  final int branch_id;
  final int day_session_id;
  final int employee_id;
  final int? pos_id;
  final int? pos_session_id;
  final int order_type_id;
  final int order_id;
  final int customer_id;
  final int product_id;
  final int? warehouse_id;
  final int? unit_id;
  final int? location_id;
  final String? removal_strategy;
  final String? valuation;
  final String? note;
  final String? type;
  final int? cost;
  final int? pos_production_time;
  final int? multi_quantity_rate;
  final String? queue_type;
  final int? quantity;
  final int? bonus_quantity;
  final int? price;
  final int? actual_price;
  final int? is_done;
  final int? total_price;
  final int? total_cost;
  final String? bom_snapshot;
  final String? created_at;
  final Product product;

  OrderItem(
      this.id,
      this.branch_id,
      this.day_session_id,
      this.employee_id,
      this.pos_id,
      this.pos_session_id,
      this.order_type_id,
      this.order_id,
      this.customer_id,
      this.product_id,
      this.warehouse_id,
      this.unit_id,
      this.location_id,
      this.removal_strategy,
      this.valuation,
      this.note,
      this.type,
      this.cost,
      this.pos_production_time,
      this.multi_quantity_rate,
      this.queue_type,
      this.quantity,
      this.bonus_quantity,
      this.price,
      this.actual_price,
      this.is_done,
      this.total_price,
      this.total_cost,
      this.bom_snapshot,
      this.created_at,
      this.product
  );
}
