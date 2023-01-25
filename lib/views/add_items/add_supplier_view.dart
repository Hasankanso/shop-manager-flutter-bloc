import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class AddSupplierView extends StatelessWidget {
  const AddSupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a new Provider".i18n()),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Name".i18n(),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Address".i18n(),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Phone Number".i18n(),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Create Supplier".i18n()),
            )
          ],
        ),
      ),
    );
  }
}
