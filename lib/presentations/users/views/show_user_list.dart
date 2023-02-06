import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/presentations/components/table_component/generic_data_source.dart';
import 'package:shop_manager/presentations/components/table_component/table_component.dart';
import 'package:shop_manager/presentations/users/components/user_row.dart';
import 'package:shop_manager/presentations/users/blocs/user_bloc.dart';
import 'package:shop_manager/presentations/users/states/users_state.dart';

class ShowUserList extends StatelessWidget {
  const ShowUserList({super.key});

  @override
  Widget build(BuildContext context) {
    var usersController = context.watch<UserBloc>();
    var state = usersController.state;

    final Widget body;
    switch (usersController.state.status) {
      case UserStatus.initial:
        body = Center(child: Text('No users found'.i18n()));
        break;
      case UserStatus.loading:
        body = const Center(child: CircularProgressIndicator());
        break;
      case UserStatus.loaded:
        if (state.users.isEmpty) {
          body = Center(child: Text('No users found'.i18n()));
        } else {
          final List<Widget> columnWidgets = state.users[0]
              .toJson()
              .keys
              .map((key) => Text(key.i18n()))
              .toList();

          body = UnifiedTable(
            columnWidgets: columnWidgets,
            rowSource: GenericDataSource(
                state.users
                    .map((user) => UserRow(user).getRowWidgets())
                    .toList(),
                state.usersAbsoluteCount,
                state.page,
                usersController.state.pageSize),
            onPageChanged: usersController.setPage,
            rowsPerPage: usersController.state.pageSize,
            onRowsPerPageChanged: usersController.setPageSize,
          );
        }
        break;
      case UserStatus.error:
        body = Center(child: Text('Error'.i18n()));
        break;
      default:
        body = Center(child: Text('No users found'.i18n()));
        break;
    }
    return Scaffold(
      appBar: AppBar(),
      body: body,
    );
  }
}
