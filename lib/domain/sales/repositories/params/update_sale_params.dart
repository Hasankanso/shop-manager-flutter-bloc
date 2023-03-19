import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class UpdateSaleParams extends Table {
  final String? productId;
  final String? productCost;
  final String? productPrice;
  final String? productQuantity;
  final String? productDiscount;
  final String? customerId;
  final String? userId;

  UpdateSaleParams(
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
    return UpdateSaleParams(
      id: json['id'],
      productId: json['productId'],
      productCost: json['productCost'],
      productPrice: json['productPrice'],
      productQuantity: json['productQuantity'],
      productDiscount: json['productDiscount'],
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
}
