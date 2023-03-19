import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/presentations/auth/blocs/auth_bloc.dart';
import 'package:uuid/uuid.dart';

class CreateAccountForm extends StatelessWidget {
  CreateAccountForm({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "First Name".i18n(),
            ),
            controller: firstNameController,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Last Name".i18n(),
            ),
            controller: lastNameController,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Position".i18n(),
            ),
            controller: positionController,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Username".i18n(),
            ),
            controller: userNameController,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Password".i18n(),
            ),
            controller: passwordController,
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .createRootUser(
                    User(
                      id: const Uuid().v4(),
                      username: userNameController.text,
                      password: passwordController.text,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      position: positionController.text,
                    ),
                  )
                  .then((_) => Navigator.pop(context));
            },
            child: Text("Create Account".i18n()),
          )
        ],
      ),
    );
  }
}
