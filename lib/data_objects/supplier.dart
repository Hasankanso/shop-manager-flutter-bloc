import 'package:shop_manager/repository/utils/jsonizer.dart';

class Supplier extends Table {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String website;
  final String description;
  String _id = "";

  Supplier(
      {this.name = "",
      this.address = "",
      this.phone = "",
      this.email = "",
      this.website = "",
      this.description = ""});

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      website: json['website'],
      description: json['description'],
    );
  }

  @override
  Table fromJson(Map<String, dynamic> json) {
    return Supplier.fromJson(json);
  }

  @override
  List<Table> fromJsonList(List<Map<String, dynamic>> jsonList) {
    List<Table> list = [];
    for (final json in jsonList) {
      list.add(Supplier.fromJson(json));
    }
    return list;
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
