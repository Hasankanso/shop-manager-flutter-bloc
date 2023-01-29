import 'package:flutter/material.dart';

class GenericDataSource<T> extends DataTableSource {
  late final List<DataRow> _data;

  GenericDataSource(List<List<Widget>> widgets) {
    _data = widgets
        .map((rowWidget) => DataRow(
            cells:
                rowWidget.map((cellWidget) => DataCell(cellWidget)).toList()))
        .toList();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    return _data[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 1;
}
