import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/products/entities/product.dart';
import 'package:shop_manager/presentations/products/blocs/product_bloc.dart';

class SellProductView extends StatelessWidget {
  SellProductView({super.key, required this.product});

  final Product product;
  final TextEditingController quantityController =
      TextEditingController(text: "1");
  late final TextEditingController priceController =
      TextEditingController(text: product.price.toString());

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: key,
        child: Column(
          children: [
            Text(product.name),
            Text(product.price.toString()),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Quantity".i18n(),
              ),
              validator: (value) {
                int? parsed = int.tryParse(quantityController.text);
                if (parsed == null) {
                  return "Quantity must be a number".i18n();
                }
                return null;
              },
              controller: quantityController,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Price".i18n(),
              ),
              validator: (value) {
                double? parsed = double.tryParse(priceController.text);
                if (parsed == null) {
                  return "Price must be a number".i18n();
                }
                return null;
              },
              controller: priceController,
            ),
            ElevatedButton(
              onPressed: () async {
                if (!key.currentState!.validate()) {
                  return;
                }
                await context.read<ProductBloc>().sellProduct(
                    product,
                    int.parse(quantityController.text),
                    double.parse(priceController.text));
              },
              child: Text("Sell".i18n()),
            )
          ],
        ),
      ),
    );
  }
}
