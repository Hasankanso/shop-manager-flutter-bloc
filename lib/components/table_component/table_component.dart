import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/components/table_component/generic_data_source.dart';

class UnifiedTable extends StatelessWidget {
  const UnifiedTable(
      {super.key, required this.columnWidgets, required this.rowSource});

  final List<Widget> columnWidgets;
  final GenericDataSource rowSource;

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
        rowsPerPage: 10,
        columns: columnWidgets.map((e) => DataColumn2(label: e)).toList(),
        source: rowSource);
  }
}
