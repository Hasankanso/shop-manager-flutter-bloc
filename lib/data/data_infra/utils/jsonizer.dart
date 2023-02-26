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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'id': id,
      'createdAt': createdAt,
      'isDeleted': isDeleted ?? false ? 1 : 0,
    };

    if (createdAt == null) {
      json['createdAt'] = DateTime.now();
    }

    if (updatedAt != null) {
      json['updatedAt'] = updatedAt;
    }

    if (deletedAt != null) {
      json['deletedAt'] = deletedAt;
    }

    return json;
  }

  Table fromJson(Map<String, dynamic> json);
  List<Table> fromJsonList(List<Map<String, dynamic>> jsonList);
}
