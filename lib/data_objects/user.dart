import 'package:equatable/equatable.dart';
import 'package:shop_manager/repository/utils/jsonizer.dart';

class User extends Equatable implements Table {
  @override
  String id;
  String firstName;
  String lastName;
  String position;

  fullName() => "$firstName $lastName";

  User(
      {this.id = "",
      this.firstName = "",
      this.lastName = "",
      this.position = ""});

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
