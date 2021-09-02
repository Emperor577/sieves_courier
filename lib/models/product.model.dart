class Product {
  final int id;
  final int inventory_category_id;
  final int pos_category_id;
  final int inventory_group_id;
  final int unit_id;
  final int? purchase_unit_id;
  final String balance_check;
  final String name;
  final String removal_strategy;
  final String valuation;
  final int photo_id;
  final int is_sell;
  final int is_buy;
  final int is_expense;
  final int is_hot_cabin;
  final int is_pos;
  final int is_change;
  final int is_active;
  final int is_for_remote_access;
  final int is_stock_track;
  final String out_of_stock;
  final String type;
  final String? ref_num;
  final String? barcode;
  final String? price;
  final String? volume;
  final String? length;
  final String? width;
  final String? height;
  final int cost;
  final int current_cost;
  final String? note;
  final String? sales_description;
  final String? purchase_description;
  final String? route;
  final String? weight;
  final int? pos_production_time;
  final String? customer_lead_time;
  final String? depreciation_time;
  final String? depreciation_value_rate;
  final int? multi_quantity_rate;
  final String? queue_type;
  final String? manufacture_time;
  final int? is_pos_changeable;
  final int? is_pos_produceable;
  final int? is_pos_stock_remove;
  final String? description;
  final String? created_at;

  Product(
      this.id,
      this.inventory_category_id,
      this.pos_category_id,
      this.inventory_group_id,
      this.unit_id,
      this.purchase_unit_id,
      this.balance_check,
      this.name,
      this.removal_strategy,
      this.valuation,
      this.photo_id,
      this.is_sell,
      this.is_buy,
      this.is_expense,
      this.is_hot_cabin,
      this.is_pos,
      this.is_change,
      this.is_active,
      this.is_for_remote_access,
      this.is_stock_track,
      this.out_of_stock,
      this.type,
      this.ref_num,
      this.barcode,
      this.price,
      this.volume,
      this.length,
      this.width,
      this.height,
      this.cost,
      this.current_cost,
      this.note,
      this.sales_description,
      this.purchase_description,
      this.route,
      this.weight,
      this.pos_production_time,
      this.customer_lead_time,
      this.depreciation_time,
      this.depreciation_value_rate,
      this.multi_quantity_rate,
      this.queue_type,
      this.manufacture_time,
      this.is_pos_changeable,
      this.is_pos_produceable,
      this.is_pos_stock_remove,
      this.description,
      this.created_at
  );
}
