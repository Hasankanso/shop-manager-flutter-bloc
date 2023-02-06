import 'package:equatable/equatable.dart';
import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class Person extends Table implements Equatable {
  final String firstName;
  final String lastName;
  final String position;

  fullName() => "$firstName $lastName";

  Person({
    required String id,
    this.firstName = "",
    this.lastName = "",
    this.position = "",
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) : super(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            isDeleted: isDeleted);

  @override
  toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "position": position,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "deletedAt": deletedAt,
    };
  }

  @override
  Table fromJson(Map<String, dynamic> json) {
    return Person(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        position: json['position'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        deletedAt: json['deletedAt'],
        isDeleted: json['isDeleted']);
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
