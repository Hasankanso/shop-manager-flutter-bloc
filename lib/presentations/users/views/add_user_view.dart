import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/presentations/users/blocs/interfaces/user_bloc_interface.dart';
import 'package:uuid/uuid.dart';

class AddUserView extends StatelessWidget {
  AddUserView({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create a new User".i18n()),
        ),
        body: Center(
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
              ElevatedButton(
                onPressed: () async {
                  User user = User(
                    id: const Uuid().v4(),
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    position: positionController.text,
                  );

                  context
                      .read<UserBlocInterface>()
                      .createUser(user)
                      .then((value) => Navigator.pop(context));
                },
                child: Text("Create Account".i18n()),
              )
            ],
          ),
        ));
  }
}
