import 'package:flutter/widgets.dart';
import 'package:shop_manager/domain/sales/entities/sale.dart';

class SaleRow {
  final Sale item;
  late final List<Widget> rowWidgets;

  SaleRow(this.item) {
    rowWidgets =
        item.toJson().values.map((value) => Text(value.toString())).toList();
  }

  List<Widget> getRowWidgets() {
    return rowWidgets;
  }
}
