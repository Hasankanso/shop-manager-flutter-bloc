import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class UpdateUserParams extends Table {
  final String? name;
  final String? email;
  final String? password;
  final String? role;

  UpdateUserParams({
    required String id,
    this.name,
    this.email,
    this.password,
    this.role,
    bool? isDeleted = false,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
          isDeleted: isDeleted,
        );

  @override
  Table fromJson(Map<String, dynamic> json) {
    return UpdateUserParams(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      isDeleted: json['isDeleted'],
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
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'isDeleted': isDeleted,
    };
  }
}
