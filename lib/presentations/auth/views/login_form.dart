import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/presentations/auth/blocs/auth_bloc.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authWatcher = context.watch<AuthBloc>();
    var authReader = context.read<AuthBloc>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Username".i18n(),
            ),
            controller: authWatcher.state.userNameController,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Password".i18n(),
            ),
            controller: authWatcher.state.passwordController,
          ),
          ElevatedButton(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              await context.read<AuthBloc>().login();
            },
            child: Text("Login".i18n()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Remember me".i18n()),
              Checkbox(
                  value: authWatcher.state.rememberMe,
                  onChanged: authReader.switchRememberMe),
            ],
          )
        ],
      ),
    );
  }
}
