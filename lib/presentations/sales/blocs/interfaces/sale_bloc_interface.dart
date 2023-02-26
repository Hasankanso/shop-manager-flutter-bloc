import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_manager/presentations/sales/states/sale_state.dart';
import 'package:shop_manager/presentations/tables/states/table_provider_interface.dart';

abstract class SaleBlocInterface extends Cubit<SaleState>
    implements TableProviderInterface {
  SaleBlocInterface(SaleState initialState) : super(initialState);
  void get();
  void create();
  void update();
  void delete();
}
