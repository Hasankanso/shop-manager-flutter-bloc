import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/products/entities/product.dart';

class ProductRow {
  final Product product;
  late final List<Widget> rowWidgets;

  ProductRow(this.product) {
    rowWidgets = product
        .getValues()
        .map((value) => Text(value?.toString() ?? "N/A".i18n()))
        .toList();
  }

  List<Widget> getRowWidgets() {
    return rowWidgets;
  }
}
