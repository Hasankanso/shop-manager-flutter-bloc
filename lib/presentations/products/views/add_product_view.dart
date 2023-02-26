import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/products/entities/product.dart';
import 'package:shop_manager/presentations/products/blocs/product_bloc.dart';
import 'package:uuid/uuid.dart';

class AddProductView extends StatelessWidget {
  AddProductView({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: key,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Name".i18n(),
              ),
              controller: nameController,
            ),
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Price".i18n(),
                ),
                controller: priceController,
                validator: (value) {
                  double? parsed = double.tryParse(priceController.text);
                  if (parsed == null) {
                    return "Price must be a number".i18n();
                  }
                  return null;
                }),
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Cost".i18n(),
                ),
                controller: costController,
                validator: (value) {
                  double? parsed = double.tryParse(costController.text);
                  if (parsed == null) {
                    return "Cost must be a number".i18n();
                  }
                  return null;
                }),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Description".i18n(),
              ),
              controller: descriptionController,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Category".i18n(),
              ),
              controller: categoryController,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Quantity".i18n(),
              ),
              controller: quantityController,
              validator: (value) {
                int? parsed = int.tryParse(quantityController.text);
                if (parsed == null) {
                  return "Quantity must be a number".i18n();
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (key.currentState?.validate() ?? false) {
                  int quantity = int.parse(quantityController.text);
                  Product p = Product(
                    id: const Uuid().v4(),
                    name: nameController.text,
                    price: double.parse(priceController.text),
                    cost: double.parse(costController.text),
                    description: descriptionController.text,
                    category: categoryController.text,
                    image: "",
                    quantity: quantity,
                  );

                  await context.read<ProductBloc>().createProduct(p);
                }
              },
              child: Text("Create".i18n()),
            )
          ],
        ),
      ),
    );
  }
}
