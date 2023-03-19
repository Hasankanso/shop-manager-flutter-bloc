import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/sales/usecases/delete_sale_case.dart';
import 'package:shop_manager/domain/sales/usecases/get_sale_case.dart';
import 'package:shop_manager/domain/sales/usecases/update_sale_case.dart';
import 'package:shop_manager/presentations/sales/blocs/interfaces/sale_bloc_interface.dart';
import 'package:shop_manager/presentations/sales/states/sale_state.dart';

class SaleBloc extends SaleBlocInterface {
  late final GetAllSaleCase getAllSaleCase;
  late final UpdateSaleCase updateSaleCase;
  late final DeleteSaleCase deleteSaleCase;

  final GetIt di;

  SaleBloc(this.di) : super(const SaleState(items: [])) {
    getAllSaleCase = di.get<GetAllSaleCase>();
    updateSaleCase = di.get<UpdateSaleCase>();
    deleteSaleCase = di.get<DeleteSaleCase>();
  }

  @override
  void nextPage() {
    emit(state.copyWith(page: state.page + 1, status: SalesPageStatus.loading));
    get();
  }

  @override
  void previousPage() {
    emit(state.copyWith(page: state.page - 1, status: SalesPageStatus.loading));
    get();
  }

  @override
  void setPage(int? newPage) {
    emit(state.copyWith(page: newPage ?? 1, status: SalesPageStatus.loading));
    get();
  }

  @override
  void setPageSize(int? newPageSize) {
    emit(state.copyWith(
        pageSize: newPageSize ?? 10, status: SalesPageStatus.loading));
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
    var response = await getAllSaleCase
        .execute(GetAllParams(page: 1, pageSize: state.pageSize));

    response.fold(
        (l) => emit(state.copyWith(
            status: SalesPageStatus.error, errorMessage: l.message.i18n())),
        (response) => emit(state.copyWith(
            currentItem: state.currentItem,
            items: response.items,
            status: SalesPageStatus.loaded,
            usersAbsoluteCount: response.absoluteCount)));
  }

  @override
  void update() {
    // TODO: implement update
  }
}
