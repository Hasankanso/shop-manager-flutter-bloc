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
                if (parsed > product.quantity) {
                  return "Required Quantity is not available".i18n() +
                      " ${product.quantity}".i18n();
                }
                if (parsed <= 0) {
                  return "Quantity must be greater than zero".i18n();
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

                double price = double.parse(priceController.text);
                int quantity = int.parse(quantityController.text);

                if (price < product.cost) {
                  showDialog(
                      context: context,
                      builder: ((dialogContext) {
                        return AlertDialog(
                          title: Text(
                              "Warning! You're not making profit with this action, are you sure? the losses"
                                      .i18n() +
                                  ": ${product.cost - price}".i18n()),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                              },
                              child: Text("No".i18n()),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(dialogContext).pop();
                                await context
                                    .read<ProductBloc>()
                                    .sellProduct(product, quantity, price);
                              },
                              child: Text("Yes".i18n()),
                            ),
                          ],
                        );
                      }));
                } else {
                  await context
                      .read<ProductBloc>()
                      .sellProduct(product, quantity, price);
                }
              },
              child: Text("Sell".i18n()),
            )
          ],
        ),
      ),
    );
  }
}
