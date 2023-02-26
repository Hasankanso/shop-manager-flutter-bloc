import 'package:flutter/widgets.dart';
import 'package:shop_manager/domain/products/entities/product.dart';

class ProductRow {
  final Product product;
  late final List<Widget> rowWidgets;

  ProductRow(this.product) {
    rowWidgets =
        product.toJson().values.map((value) => Text(value.toString())).toList();
  }

  List<Widget> getRowWidgets() {
    return rowWidgets;
  }
}
