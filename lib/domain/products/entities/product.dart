import 'package:equatable/equatable.dart';
import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class Product extends Table implements Equatable {
  final String name;
  final String description;
  final double price;
  final String? image;
  final String category;
  final double cost;
  final int quantity;

  Product.fromEmpty({
    this.name = "",
    this.description = "",
    this.price = 0,
    this.image,
    this.category = "",
    this.cost = 0,
    this.quantity = 0,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) : super(
            id: '',
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            isDeleted: isDeleted);

  Product({
    required this.name,
    required this.description,
    required this.price,
    this.image,
    required this.category,
    required this.cost,
    required this.quantity,
    required id,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) : super(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            isDeleted: isDeleted);

  @override
  toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "image": image,
      "category": category,
      "cost": cost,
      "quantity": quantity,
      ...super.toJson(),
    };
  }

  @override
  Table fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price']),
      // image: json['image'],
      category: json['category'],
      id: json['id'],
      cost: double.parse(json['cost']),
      quantity: int.parse(json['quantity']),
      isDeleted: json['isDeleted'] == 1,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
      deletedAt: DateTime.tryParse(json['deletedAt'] ?? ''),
    );
  }

  @override
  List<Table> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((e) => fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => false;

  static List<String> getColumns() {
    return [
      "id",
      "name",
      "description",
      "price",
      "image",
      "category",
      "cost",
      "quantity",
      "isDeleted",
      "createdAt",
      "updatedAt",
      "deletedAt",
    ];
  }

  List<dynamic> getValues() {
    return [
      id,
      name,
      description,
      price,
      image,
      category,
      cost,
      quantity,
      isDeleted,
      createdAt,
      updatedAt,
      deletedAt,
    ];
  }
}
