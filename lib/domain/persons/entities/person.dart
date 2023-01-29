import 'package:equatable/equatable.dart';
import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class Person extends Equatable implements Table {
  @override
  final String id;
  final String firstName;
  final String lastName;
  final String position;

  fullName() => "$firstName $lastName";

  Person(
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
    return Person(
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
