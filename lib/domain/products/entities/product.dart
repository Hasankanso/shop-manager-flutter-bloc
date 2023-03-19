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
  final String barcode;
  String? priceId;

  Product.fromEmpty({
    this.name = "",
    this.description = "",
    this.price = 0,
    this.image,
    this.category = "",
    this.cost = 0,
    this.quantity = 0,
    this.barcode = "",
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) : super(
            id: '',
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt);

  Product({
    required this.name,
    required this.description,
    required this.price,
    this.image,
    required this.category,
    required this.cost,
    required this.quantity,
    required id,
    required this.barcode,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) : super(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt);

  @override
  toJson() {
    return {
      "name": name,
      "description": description,
      "priceId": priceId,
      "image": image,
      "category": category,
      "quantity": quantity,
      "barcode": barcode,
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
      barcode: json['barcode'] ?? "",
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
      deletedAt: DateTime.tryParse(json['deletedAt'] ?? ''),
    );
  }

  //copyWith
  Product copyWith({
    String? name,
    String? description,
    double? price,
    String? image,
    String? category,
    double? cost,
    int? quantity,
    String? id,
    String? barcode,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Product(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
      cost: cost ?? this.cost,
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
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
      "name",
      "description",
      "price",
      "image",
      "category",
      "cost",
      "quantity",
      "createdAt",
    ];
  }

  List<dynamic> getValues() {
    return [
      name,
      description,
      price,
      image,
      category,
      cost,
      quantity,
      createdAt,
    ];
  }
}
