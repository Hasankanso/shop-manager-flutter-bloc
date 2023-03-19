import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/products/entities/product.dart';
import 'package:shop_manager/domain/products/usecases/create.dart';
import 'package:shop_manager/domain/products/usecases/get_all.dart';
import 'package:shop_manager/domain/products/usecases/sell.dart';
import 'package:shop_manager/presentations/products/blocs/interface.dart';
import 'package:shop_manager/presentations/products/states/state.dart';
import 'package:shop_manager/presentations/auth/blocs/auth_bloc.dart';

class ProductBloc extends ProductBlocInterface {
  late final CreateProductCase createProductCase;
  late final GetAllProductsCase getAllProductsCase;
  late final SellProductCase sellProductCase;
  final AuthBloc authController;

  final GetIt di;

  ProductBloc(this.di, this.authController) : super(const ProductState()) {
    createProductCase = di.get<CreateProductCase>();
    getAllProductsCase = di.get<GetAllProductsCase>();
    sellProductCase = di.get<SellProductCase>();
  }

  @override
  void getProducts() async {
    var response = await getAllProductsCase
        .execute(GetAllParams(page: 1, pageSize: state.pageSize));

    response.fold(
        (l) => emit(state.copyWith(
            status: PageStatus.error, errorMessage: l.message.i18n())),
        (response) => emit(state.copyWith(
            currentProduct: state.currentProduct,
            products: response.users,
            status: PageStatus.loaded,
            productsAbsoluteCount: response.absoluteCount)));
  }

  @override
  void nextPage() {
    emit(state.copyWith(page: state.page + 1, status: PageStatus.loading));
    getProducts();
  }

  @override
  void previousPage() {
    emit(state.copyWith(page: state.page - 1, status: PageStatus.loading));
    getProducts();
  }

  @override
  void setPage(int? newPage) {
    emit(state.copyWith(page: newPage ?? 1, status: PageStatus.loading));
    getProducts();
  }

  @override
  void setPageSize(int? newPageSize) {
    emit(state.copyWith(
        pageSize: newPageSize ?? 10, status: PageStatus.loading));
    getProducts();
  }

  @override
  Future<void> buyProduct(Product p, int quantity, double price) async {
    // TODO: implement buyProduct
  }

  @override
  Future<void> createProduct(Product p) async {
    var response = await createProductCase.execute({"product": p});

    response.fold(
        (l) => emit(state.copyWith(
            status: PageStatus.error, errorMessage: l.message.i18n())),
        (response) {});
  }

  @override
  Future<void> deleteProduct(Product p) async {
    // TODO: implement deleteProduct
  }

  @override
  Future<void> editProduct(Product p) async {
    // TODO: implement editProduct
  }

  @override
  Future<void> searchProduct(String searchString) async {
    var response = await getAllProductsCase.execute(GetAllParams(
        page: 1,
        pageSize: state.pageSize,
        containsFilter: {"name": searchString, "description": searchString}));

    response.fold(
        (l) => emit(state.copyWith(
            status: PageStatus.error, errorMessage: l.message.i18n())),
        (response) => emit(state.copyWith(
            currentProduct: state.currentProduct,
            products: response.users,
            status: PageStatus.loaded,
            productsAbsoluteCount: response.absoluteCount)));
  }

  @override
  Future<void> selectProduct({int? index}) async {
    if (index != null) {
      emit(state.copyWith(
          selectedIndex: index, currentProduct: state.products[index]));
    } else {
      emit(state.copyWith(selectedIndex: null, currentProduct: null));
    }
  }

  @override
  Future<void> sellProduct(Product p, int quantity, double price) async {
    var response = await sellProductCase.execute({
      "product": p,
      "quantity": quantity,
      "price": price,
      "user": authController.state.loggedUser,
    });

    response.fold(
        (l) => emit(state.copyWith(
            status: PageStatus.error, errorMessage: l.message.i18n())),
        (response) {});
  }
}
