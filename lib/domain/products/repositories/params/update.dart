import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class UpdateProductParams extends Table {
  String? name;
  String? description;
  double? price;
  String? image;
  String? category;
  double? cost;
  int? quantity;

  UpdateProductParams({
    required String id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.category,
    this.cost,
    this.quantity,
    bool? isDeleted = false,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) : super(
          id: id,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
          isDeleted: isDeleted,
        );

  @override
  Table fromJson(Map<String, dynamic> json) {
    return UpdateProductParams(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      category: json['category'],
      cost: json['cost'],
      quantity: json['quantity'],
      isDeleted: json['isDeleted'],
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
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "image": image,
      "category": category,
      "cost": cost,
      "quantity": quantity,
      "isDeleted": isDeleted,
      "updatedAt": updatedAt,
      "deletedAt": deletedAt,
    };
  }
}
