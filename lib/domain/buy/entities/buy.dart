import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class Buy extends Table {
  final String? productId;
  final String? productCost;
  final String? productPrice;
  final String? productQuantity;
  final String? productDiscount;
  final String? supplierId;
  final String? userId;

  Buy(
      {required String id,
      this.productId,
      this.productCost,
      this.productPrice,
      this.productQuantity,
      this.productDiscount,
      this.supplierId,
      this.userId,
      createdAt,
      updatedAt,
      deletedAt})
      : super(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt);

  @override
  Table fromJson(Map<String, dynamic> json) {
    return Buy(
      id: json['id'],
      productId: json['productId'],
      productCost: json['productCost'],
      productPrice: json['productPrice'],
      productQuantity: json['productQuantity'],
      productDiscount: json['productDiscount'],
      supplierId: json['supplierId'],
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
    return {
      'productId': productId,
      'productCost': productCost,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
      'productDiscount': productDiscount,
      'supplierId': supplierId,
      'userId': userId,
      ...super.toJson(),
    };
  }
}
