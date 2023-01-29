import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/presentations/components/table_component/generic_data_source.dart';
import 'package:shop_manager/presentations/components/table_component/table_component.dart';
import 'package:shop_manager/presentations/components/users_table/user_row.dart';

class UserTable extends StatelessWidget {
  final List<User> users;
  late final List<List<Widget>> userRows;
  final Function(int?)? onRowsPerPageChanged;
  final Function(int?)? onPageChanged;
  final int rowsPerPage;

  UserTable(
      {super.key,
      required this.users,
      this.onRowsPerPageChanged,
      this.onPageChanged,
      required this.rowsPerPage}) {
    userRows = users.map((user) => UserRow(user).getRowWidgets()).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return Center(child: Text("No Users Found".i18n()));
    }

    List<Widget> columnWidgets =
        users[0].toJson().keys.map((key) => Text(key)).toList();
    return UnifiedTable(
      columnWidgets: columnWidgets,
      rowSource: GenericDataSource(userRows),
      onPageChanged: onPageChanged,
      rowsPerPage: rowsPerPage,
      onRowsPerPageChanged: onRowsPerPageChanged,
    );
  }
}
