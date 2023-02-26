import 'package:equatable/equatable.dart';
import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class Sell extends Table implements Equatable {
  final String? productId;
  final double? productCost;
  final double? productPrice;
  final int? productQuantity;
  final double? productDiscount;
  final String? customerId;
  final String? userId;

  Sell(
      {required String id,
      this.productId,
      this.productCost,
      this.productPrice,
      this.productQuantity,
      this.productDiscount,
      this.customerId,
      this.userId,
      bool? isDeleted = false,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt})
      : super(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            isDeleted: isDeleted);

  @override
  Table fromJson(Map<String, dynamic> json) {
    return Sell(
      id: json['id'],
      productId: json['productId'],
      productCost: double.parse(json['productCost']),
      productPrice: double.parse(json['productPrice']),
      productQuantity: int.parse(json['productQuantity']),
      productDiscount: double.parse(json['productDiscount']),
      customerId: json['customerId'],
      userId: json['userId'],
    );
  }

  @override
  List<Table> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productCost': productCost,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
      'productDiscount': productDiscount,
      'customerId': customerId,
      'userId': userId,
    };
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
}
