import 'package:flutter/material.dart';

class GenericDataSource<T> extends DataTableSource {
  late final List<DataRow>? _data;
  final int fullLength;
  final int page;
  final int rowsPerPage;
  final Function(int index, bool selected)? onSelectChanged;
  final int? selectedIndex;

  GenericDataSource(
      List<List<Widget>> widgets, this.fullLength, this.page, this.rowsPerPage,
      {this.onSelectChanged, this.selectedIndex}) {
    _data = widgets
        .asMap()
        .entries
        .map((entry) => DataRow(
            onSelectChanged: (value) {
              if (onSelectChanged != null) {
                onSelectChanged!(entry.key, value ?? true);
              }
            },
            selected: (selectedIndex ?? -1) == entry.key,
            cells:
                entry.value.map((cellWidget) => DataCell(cellWidget)).toList()))
        .toList();
  }

  @override
  DataRow? getRow(int index) {
    int virtualIndex = index % rowsPerPage;

    if (virtualIndex >= (_data?.length ?? 0)) {
      return null;
    }

    return _data?[virtualIndex];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => fullLength;

  @override
  int get selectedRowCount => 1;
}
