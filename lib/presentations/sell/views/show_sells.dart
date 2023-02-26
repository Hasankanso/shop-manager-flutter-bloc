import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/presentations/components/table_component/generic_data_source.dart';
import 'package:shop_manager/presentations/components/table_component/table_component.dart';
import 'package:shop_manager/presentations/sell/components/sell_row.dart';
import 'package:shop_manager/presentations/sell/blocs/sell_bloc.dart';
import 'package:shop_manager/presentations/sell/states/sell_state.dart';

class ShowSellList extends StatelessWidget {
  const ShowSellList({super.key});

  @override
  Widget build(BuildContext context) {
    var sellsController = context.watch<SellBloc>();
    var state = sellsController.state;

    final Widget body;
    switch (sellsController.state.status) {
      case SellPageStatus.initial:
        body = Center(child: Text('No users found'.i18n()));
        break;
      case SellPageStatus.loading:
        body = const Center(child: CircularProgressIndicator());
        break;
      case SellPageStatus.loaded:
        if (state.items.isEmpty) {
          body = Center(child: Text('No items found'.i18n()));
        } else {
          final List<Widget> columnWidgets = state.items[0]
              .toJson()
              .keys
              .map((key) => Text(key.i18n()))
              .toList();

          body = UnifiedTable(
            columnWidgets: columnWidgets,
            rowSource: GenericDataSource(
                state.items
                    .map((item) => SellRow(item).getRowWidgets())
                    .toList(),
                state.usersAbsoluteCount,
                state.page,
                state.pageSize),
            onPageChanged: sellsController.setPage,
            rowsPerPage: sellsController.state.pageSize,
            onRowsPerPageChanged: sellsController.setPageSize,
          );
        }
        break;
      case SellPageStatus.error:
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
