import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/products/entities/product.dart';
import 'package:shop_manager/domain/products/repositories/params/update.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

abstract class ProductRepoInterface {
  Future<Either<RequestError, Product>> getProduct(String id);
  Future<Either<RequestError, List<Product>>> getProducts(GetAllParams args);
  Future<Either<RequestError, void>> createProduct(Product item);
  Future<Either<RequestError, void>> updateProduct(UpdateProductParams args);
  Future<Either<RequestError, void>> deleteProduct(DeleteParams args);

  FutureOr<Either<RequestError, int>> getAllProductsCount();
}
