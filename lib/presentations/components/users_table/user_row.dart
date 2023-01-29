import 'package:flutter/widgets.dart';
import 'package:shop_manager/domain/users/entities/user.dart';

class UserRow {
  final User user;
  late final List<Widget> rowWidgets;

  UserRow(this.user) {
    rowWidgets =
        user.toJson().values.map((value) => Text(value.toString())).toList();
  }

  List<Widget> getRowWidgets() {
    return rowWidgets;
  }
}
