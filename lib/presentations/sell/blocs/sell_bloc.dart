import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/sell/usecases/create_sell_case.dart';
import 'package:shop_manager/domain/sell/usecases/delete_sell_case.dart';
import 'package:shop_manager/domain/sell/usecases/get_sell_case.dart';
import 'package:shop_manager/domain/sell/usecases/update_sell_case.dart';
import 'package:shop_manager/presentations/sell/blocs/interfaces/sell_bloc_interface.dart';
import 'package:shop_manager/presentations/sell/states/sell_state.dart';

class SellBloc extends SellBlocInterface {
  late final CreateSellCase createSellCase;
  late final GetAllSellCase getAllSellCase;
  late final UpdateSellCase updateSellCase;
  late final DeleteSellCase deleteSellCase;

  final GetIt di;

  SellBloc(this.di) : super(const SellState(items: [])) {
    createSellCase = di.get<CreateSellCase>();
    getAllSellCase = di.get<GetAllSellCase>();
    updateSellCase = di.get<UpdateSellCase>();
    deleteSellCase = di.get<DeleteSellCase>();
  }

  @override
  void nextPage() {
    emit(state.copyWith(page: state.page + 1, status: SellPageStatus.loading));
    get();
  }

  @override
  void previousPage() {
    emit(state.copyWith(page: state.page - 1, status: SellPageStatus.loading));
    get();
  }

  @override
  void setPage(int? newPage) {
    emit(state.copyWith(page: newPage ?? 1, status: SellPageStatus.loading));
    get();
  }

  @override
  void setPageSize(int? newPageSize) {
    emit(state.copyWith(
        pageSize: newPageSize ?? 10, status: SellPageStatus.loading));
    get();
  }

  @override
  void create() {}

  @override
  void delete() {
    // TODO: implement delete
  }

  @override
  void get() async {
    var response = await getAllSellCase
        .execute(GetAllParams(page: state.page, pageSize: state.pageSize));

    response.fold(
        (l) => emit(state.copyWith(
            status: SellPageStatus.error, errorMessage: l.message.i18n())),
        (response) => emit(state.copyWith(
            currentItem: state.currentItem,
            items: response.items,
            status: SellPageStatus.loaded,
            usersAbsoluteCount: response.absoluteCount)));
  }

  @override
  void update() {
    // TODO: implement update
  }
}
