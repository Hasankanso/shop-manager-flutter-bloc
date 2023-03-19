abstract class Table {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Table({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'id': id,
      'createdAt': createdAt,
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
