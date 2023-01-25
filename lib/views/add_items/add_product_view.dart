import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Name".i18n(),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Price".i18n(),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Cost".i18n(),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Description".i18n(),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Category".i18n(),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Create".i18n()),
          )
        ],
      ),
    );
  }
}
