import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/sales/entities/sale.dart';
import 'package:shop_manager/presentations/components/table_component/generic_data_source.dart';
import 'package:shop_manager/presentations/components/table_component/table_component.dart';
import 'package:shop_manager/presentations/sales/components/sale_row.dart';
import 'package:shop_manager/presentations/sales/blocs/sale_bloc.dart';
import 'package:shop_manager/presentations/sales/states/sale_state.dart';

class ShowSaleList extends StatelessWidget {
  const ShowSaleList({super.key});

  @override
  Widget build(BuildContext context) {
    var salesController = context.watch<SaleBloc>();
    var state = salesController.state;

    final Widget body;
    switch (salesController.state.status) {
      case SalesPageStatus.initial:
        body = Center(child: Text('initializing...'.i18n()));
        break;
      case SalesPageStatus.loading:
        body = const Center(child: CircularProgressIndicator());
        break;
      case SalesPageStatus.loaded:
        if (state.items.isEmpty) {
          body = Center(child: Text('No items found'.i18n()));
        } else {
          final List<Widget> columnWidgets =
              Sale.getColumns().map((key) => Text(key.i18n())).toList();

          body = UnifiedTable(
            columnWidgets: columnWidgets,
            rowSource: GenericDataSource(
              state.items.map((item) => SaleRow(item).getRowWidgets()).toList(),
              state.absoluteCount,
              state.page,
              state.pageSize,
              selectedIndex: state.selectedIndex,
            ),
            onPageChanged: salesController.setPage,
            rowsPerPage: salesController.state.pageSize,
            onRowsPerPageChanged: salesController.setPageSize,
          );
        }
        break;
      case SalesPageStatus.error:
        body = Center(child: Text('Error'.i18n()));
        break;
      default:
        body = Center(child: Text('No items found'.i18n()));
        break;
    }
    return Scaffold(
      appBar: AppBar(),
      body: body,
    );
  }
}
