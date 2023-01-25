import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class AddCustomerView extends StatelessWidget {
  const AddCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      TextField(
        decoration: InputDecoration(
          labelText: "Name".i18n(),
        ),
      ),
      TextField(
        decoration: InputDecoration(
          labelText: "Phone".i18n(),
        ),
      ),
      TextField(
        decoration: InputDecoration(
          labelText: "Address".i18n(),
        ),
      ),
      TextField(
        decoration: InputDecoration(
          labelText: "Email".i18n(),
        ),
      ),
      ElevatedButton(
        onPressed: () {},
        child: Text("Create".i18n()),
      )
    ]));
  }
}
