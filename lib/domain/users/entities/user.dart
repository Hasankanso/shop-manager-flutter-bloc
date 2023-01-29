import 'package:equatable/equatable.dart';
import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class User extends Equatable implements Table {
  @override
  final String id;
  final String firstName;
  final String lastName;
  final String position;

  fullName() => "$firstName $lastName";

  const User(
      {this.id = "",
      this.firstName = "",
      this.lastName = "",
      this.position = ""});

  User copyWith(
      {String? id, String? firstName, String? lastName, String? position}) {
    return User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        position: position ?? this.position);
  }

  @override
  toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "position": position,
    };
  }

  @override
  Table fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        position: json['position']);
  }

  @override
  List<Table> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((e) => fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [id];
}
