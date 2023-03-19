import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class UpdateProductParams extends Table {
  String? name;
  String? description;
  String? image;
  String? category;
  double? cost;
  int? quantity;

  UpdateProductParams({
    required String id,
    this.name,
    this.description,
    this.image,
    this.category,
    this.quantity,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) : super(
          id: id,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  @override
  Table fromJson(Map<String, dynamic> json) {
    return UpdateProductParams(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      category: json['category'],
      quantity: json['quantity'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }

  @override
  List<Table> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    //add only items that are not null to the map
    Map<String, dynamic> map = {};
    if (name != null) map['name'] = name;
    if (description != null) map['description'] = description;
    if (image != null) map['image'] = image;
    if (category != null) map['category'] = category;
    if (quantity != null) map['quantity'] = quantity;
    if (updatedAt != null) map['updatedAt'] = updatedAt;
    if (deletedAt != null) map['deletedAt'] = deletedAt;
    return map;
  }
}
