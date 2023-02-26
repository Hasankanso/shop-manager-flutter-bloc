import 'package:equatable/equatable.dart';
import 'package:shop_manager/domain/products/entities/product.dart';
import 'package:shop_manager/presentations/tables/states/table_state.dart';

enum PageStatus { initial, loading, loaded, error }

///states of product modules (get all products create a product etc.)
class ProductState extends TableState implements Equatable {
  final List<Product> products;
  final Product? currentProduct;
  final int? selectedIndex;

  final PageStatus status;
  final String errorMessage;
  final int productsAbsoluteCount;

  const ProductState(
      {this.currentProduct,
      this.errorMessage = "Error",
      this.products = const [],
      page = 1,
      pageSize = 10,
      this.selectedIndex,
      this.status = PageStatus.initial,
      this.productsAbsoluteCount = 0})
      : super(page: page, pageSize: pageSize);

  ProductState copyWith(
      {Product? currentProduct,
      List<Product>? products,
      int? page,
      int? pageSize,
      bool? isLoading,
      PageStatus? status,
      String? errorMessage,
      int? productsAbsoluteCount,
      int? selectedIndex}) {
    return ProductState(
        currentProduct: currentProduct ?? this.currentProduct,
        products: products ?? this.products,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        productsAbsoluteCount:
            productsAbsoluteCount ?? this.productsAbsoluteCount,
        selectedIndex: selectedIndex ?? this.selectedIndex);
  }

  @override
  List<Object?> get props =>
      [status, currentProduct, page, pageSize, errorMessage, ...products];
}
