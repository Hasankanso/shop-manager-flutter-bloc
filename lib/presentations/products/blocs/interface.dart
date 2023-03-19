import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_manager/domain/products/entities/product.dart';
import 'package:shop_manager/presentations/products/states/state.dart';
import 'package:shop_manager/presentations/tables/states/table_provider_interface.dart';

abstract class ProductBlocInterface extends Cubit<ProductState>
    implements TableProviderInterface {
  ProductBlocInterface(ProductState initialState) : super(initialState);

  void getProducts();

  Future<void> createProduct(Product p);
  Future<void> selectProduct({int? index});
  Future<void> editProduct(Product p);
  Future<void> deleteProduct(Product p);
  Future<void> sellProduct(Product p, int quantity, double price);
  Future<void> buyProduct(Product p, int quantity, double price);
  Future<void> searchProduct(String searchString);

  @override
  void nextPage();

  @override
  void previousPage();

  @override
  void setPage(int? newPage);

  @override
  void setPageSize(int? newPageSize);
}
