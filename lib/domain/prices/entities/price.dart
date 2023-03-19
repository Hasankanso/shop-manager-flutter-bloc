import 'package:equatable/equatable.dart';
import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class Price extends Table implements Equatable {
  final String productId;
  final double price;
  final double cost;

  Price({
    required this.productId,
    required this.price,
    required this.cost,
    required id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) : super(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt);

  Price.fromEmpty({
    this.productId = "",
    this.price = 0,
    this.cost = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) : super(
            id: '',
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt);

  @override
  Table fromJson(Map<String, dynamic> json) {
    return Price(
      productId: json['productId'],
      price: json['price'],
      cost: json['cost'],
      id: json['id'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
      deletedAt: DateTime.tryParse(json['deletedAt'] ?? ''),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'price': price,
      'cost': cost,
      'id': id,
      ...super.toJson(),
    };
  }

  //copyWith
  Price copyWith({
    String? productId,
    double? price,
    double? cost,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Price(
      productId: productId ?? this.productId,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      id: id ?? this.id,
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
}
