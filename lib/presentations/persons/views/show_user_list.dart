import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/presentations/components/users_table/user_table.dart';
import 'package:shop_manager/presentations/users/blocs/user_bloc.dart';
import 'package:shop_manager/presentations/users/states/users_state.dart';

class ShowUserList extends StatelessWidget {
  const ShowUserList({super.key});

  @override
  Widget build(BuildContext context) {
    var usersController = context.watch<UserBloc>();
    final Widget body;
    switch (usersController.state.status) {
      case UserStatus.initial:
        body = Center(child: Text('No users found'.i18n()));
        break;
      case UserStatus.loading:
        body = const Center(child: CircularProgressIndicator());
        break;
      case UserStatus.loaded:
        body = UserTable(
            users: usersController.state.users,
            rowsPerPage: usersController.state.pageSize,
            onPageChanged: usersController.setPage,
            onRowsPerPageChanged: usersController.setPageSize);
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
