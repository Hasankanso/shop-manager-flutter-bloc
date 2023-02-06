import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_manager/presentations/sell/states/sell_state.dart';
import 'package:shop_manager/presentations/tables/states/table_provider_interface.dart';

abstract class SellBlocInterface extends Cubit<SellState>
    implements TableProviderInterface {
  SellBlocInterface(SellState initialState) : super(initialState);
  void get();
  void create();
  void update();
  void delete();
}
