import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_manager/components/users_table/user_table.dart';
import 'package:shop_manager/providers/user_module/user_state_provider.dart';

class ShowUserList extends StatelessWidget {
  const ShowUserList({super.key});

  @override
  Widget build(BuildContext context) {
    var usersController = context.watch<UserStateProvider>();

    return Scaffold(
        appBar: AppBar(),
        body: usersController.state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : UserTable(users: usersController.state.users));
  }
}
