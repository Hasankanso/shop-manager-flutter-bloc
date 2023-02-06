import 'package:flutter/widgets.dart';
import 'package:shop_manager/domain/sell/entities/sell.dart';

class SellRow {
  final Sell item;
  late final List<Widget> rowWidgets;

  SellRow(this.item) {
    rowWidgets =
        item.toJson().values.map((value) => Text(value.toString())).toList();
  }

  List<Widget> getRowWidgets() {
    return rowWidgets;
  }
}
