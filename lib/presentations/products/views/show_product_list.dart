import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/products/entities/product.dart';
import 'package:shop_manager/presentations/components/table_component/generic_data_source.dart';
import 'package:shop_manager/presentations/components/table_component/table_component.dart';
import 'package:shop_manager/presentations/products/blocs/product_bloc.dart';
import 'package:shop_manager/presentations/products/components/table_row.dart';
import 'package:shop_manager/presentations/products/states/state.dart';
import 'package:shop_manager/presentations/products/views/add_product_view.dart';
import 'package:shop_manager/presentations/products/views/sell_view.dart';

class ShowProductList extends StatelessWidget {
  const ShowProductList({super.key});

  @override
  Widget build(BuildContext context) {
    var productsController = context.watch<ProductBloc>();
    var state = productsController.state;

    final Widget body;
    switch (productsController.state.status) {
      case PageStatus.initial:
        body = Center(child: Text('No products found'.i18n()));
        break;
      case PageStatus.loading:
        body = const Center(child: CircularProgressIndicator());
        break;
      case PageStatus.loaded:
        if (state.products.isEmpty) {
          body = Center(child: Text('No products found'.i18n()));
        } else {
          final List<Widget> columnWidgets =
              Product.getColumns().map((key) => Text(key.i18n())).toList();

          body = UnifiedTable(
            columnWidgets: columnWidgets,
            rowSource: GenericDataSource(
              state.products
                  .map((product) => ProductRow(product).getRowWidgets())
                  .toList(),
              state.productsAbsoluteCount,
              state.page,
              productsController.state.pageSize,
              selectedIndex: state.selectedIndex,
              onSelectChanged: (index, selected) {
                if (selected) {
                  productsController.selectProduct(index: index);
                } else {
                  productsController.selectProduct();
                }
              },
            ),
            onPageChanged: productsController.setPage,
            rowsPerPage: productsController.state.pageSize,
            onRowsPerPageChanged: productsController.setPageSize,
          );
        }
        break;
      case PageStatus.error:
        body = Center(child: Text(state.errorMessage.i18n()));
        break;
      default:
        body = Center(child: Text('No products found'.i18n()));
        break;
    }
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Expanded(flex: 7, child: body),
        Expanded(
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return BlocProvider.value(
                          value: BlocProvider.of<ProductBloc>(context),
                          child: AddProductView());
                    }));
                  },
                  child: Text('Create Product'.i18n())),
              ElevatedButton(
                  onPressed: () {
                    Product? currProduct = state.currentProduct;

                    if (currProduct != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return BlocProvider.value(
                            value: BlocProvider.of<ProductBloc>(context),
                            child: SellProductView(product: currProduct));
                      }));
                    }
                  },
                  child: Text('Sell Product'.i18n())),
            ],
          ),
        )
      ]),
    );
  }
}
