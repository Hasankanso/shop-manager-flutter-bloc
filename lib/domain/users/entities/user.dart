import 'package:equatable/equatable.dart';
import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class User extends Table implements Equatable {
  final String firstName;
  final String lastName;
  final String position;

  final String password;
  final String username;

  fullName() => "$firstName $lastName";

  User({
    required String id,
    this.firstName = "",
    this.lastName = "",
    this.position = "",
    this.password = "",
    this.username = "",
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) : super(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt);

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? position,
    String? password,
    String? username,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      position: position ?? this.position,
      password: password ?? this.password,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "position": position,
      "username": username,
      "password": password,
      ...super.toJson(),
    };
  }

  @override
  Table fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      position: json['position'],
      username: json['username'],
      password: json['password'],
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
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
