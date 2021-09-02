class Branch {
  final int id;
  final String name;
  final String? code;
  final String timezone;
  final String start_work;
  final String end_work;
  final int is_hq;
  final String work_days;
  final double? lat;
  final double? lng;
  final String? created_at;

  Branch(
      this.id,
      this.name,
      this.code,
      this.timezone,
      this.start_work,
      this.end_work,
      this.is_hq,
      this.work_days,
      this.lat,
      this.lng,
      this.created_at
  );
}
