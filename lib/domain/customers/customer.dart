import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class Customer extends Table {
  String _id = "";
  final String name;
  final String address;
  final String phone;
  final String email;

  Customer(
      {this.name = "", this.address = "", this.phone = "", this.email = ""});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  @override
  Table fromJson(Map<String, dynamic> json) {
    return Customer.fromJson(json);
  }

  @override
  List<Table> fromJsonList(List<Map<String, dynamic>> jsonList) {
    List<Table> list = [];
    for (var element in jsonList) {
      list.add(Customer.fromJson(element));
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
      "name": name,
      "address": address,
      "phone": phone,
      "email": email,
    };
  }
}
