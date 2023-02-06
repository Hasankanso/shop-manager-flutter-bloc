import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/presentations/components/table_component/generic_data_source.dart';

class UnifiedTable extends StatelessWidget {
  UnifiedTable(
      {super.key,
      required this.columnWidgets,
      required this.rowSource,
      required this.rowsPerPage,
      required this.onRowsPerPageChanged,
      required this.onPageChanged});

  final List<Widget> columnWidgets;
  final GenericDataSource rowSource;
  final int rowsPerPage;
  final Function(int?)? onRowsPerPageChanged;
  final Function(int?)? onPageChanged;
  final PaginatorController controller = PaginatorController();
  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable2(
        initialFirstRowIndex: 0,
        rowsPerPage: rowsPerPage,
        onRowsPerPageChanged: onRowsPerPageChanged,
        onPageChanged: onPageChanged,
        columns: columnWidgets.map((e) => DataColumn2(label: e)).toList(),
        source: rowSource);
  }
}
