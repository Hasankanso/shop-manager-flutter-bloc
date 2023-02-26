import 'package:equatable/equatable.dart';
import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class Customer extends Table implements Equatable {
  final String name;
  final String address;
  final String phone;
  final String email;

  Customer(
      {required String id,
      this.name = "",
      this.address = "",
      this.phone = "",
      this.email = "",
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

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      isDeleted: json['isDeleted'] == 1,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
      deletedAt: DateTime.tryParse(json['deletedAt'] ?? ''),
    );
  }

  @override
  Table fromJson(Map<String, dynamic> json) {
    return Customer.fromJson(json);
  }

  @override
  List<Table> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      ...super.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, name, address, phone, email];

  @override
  bool? get stringify => true;
}
