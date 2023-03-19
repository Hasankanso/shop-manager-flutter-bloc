import 'package:equatable/equatable.dart';
import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class Sale extends Table implements Equatable {
  final String? productId;
  final double? productCost;
  final double? productPrice;
  final int? productQuantity;
  final double? productDiscount;
  final String? customerId;
  final String? userId;

  Sale(
      {required String id,
      this.productId,
      this.productCost,
      this.productPrice,
      this.productQuantity,
      this.productDiscount,
      this.customerId,
      this.userId,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt})
      : super(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt);

  @override
  Table fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'],
      productId: json['productId'],
      productCost: double.parse(json['productCost']),
      productPrice: double.parse(json['productPrice']),
      productQuantity: int.parse(json['productQuantity']),
      productDiscount: double.parse(json['productDiscount']),
      customerId: json['customerId'],
      userId: json['userId'],
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
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'productId': productId,
      'productCost': productCost,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
      'productDiscount': productDiscount,
      'customerId': customerId,
      'userId': userId,
      ...super.toJson(),
    };

    return json;
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        productCost,
        productPrice,
        productQuantity,
        productDiscount,
        customerId,
        userId,
      ];

  @override
  bool? get stringify => true;

  //getColumns
  static List<String> getColumns() {
    return [
      'productId',
      'productCost',
      'productPrice',
      'productQuantity',
      'productDiscount',
      'customerId',
      'userId',
    ];
  }

  List<Object?> getValues() {
    return [
      productId,
      productCost,
      productPrice,
      productQuantity,
      productDiscount,
      customerId,
      userId,
    ];
  }
}
