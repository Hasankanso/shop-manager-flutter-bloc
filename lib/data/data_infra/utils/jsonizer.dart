abstract class Table {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final bool? isDeleted;

  Table({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isDeleted,
  });

  Map<String, dynamic> toJson();
  Table fromJson(Map<String, dynamic> json);
  List<Table> fromJsonList(List<Map<String, dynamic>> jsonList);
}
