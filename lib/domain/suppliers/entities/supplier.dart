import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class Supplier extends Table {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String website;
  final String description;
  String _id = "";

  Supplier(
      {required String id,
      this.name = "",
      this.address = "",
      this.phone = "",
      this.email = "",
      this.website = "",
      this.description = "",
      bool? isDeleted,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt})
      : super(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            isDeleted: isDeleted);

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      website: json['website'],
      description: json['description'],
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }

  @override
  Table fromJson(Map<String, dynamic> json) {
    return Supplier.fromJson(json);
  }

  @override
  List<Table> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((e) => fromJson(e)).toList();
  }

  @override
  String get id => _id;

  set id(String value) {
    _id = value;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
      'description': description,
    };
  }
}
