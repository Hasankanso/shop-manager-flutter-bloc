import 'package:shop_manager/data/common/repo.dart';
import 'package:shop_manager/domain/products/repositories/params/update.dart';
import 'package:shop_manager/domain/products/entities/product.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:dartz/dartz.dart';
import 'dart:async';

import 'package:shop_manager/domain/products/repositories/repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

class ProductRepository extends CommonRepo<Product>
    implements ProductRepoInterface {
  ProductRepository({required db}) : super(db: db, tableName: "products");

  @override
  Future<Either<RequestError, void>> createProduct(Product item) {
    return super.create(item);
  }

  @override
  Future<Either<RequestError, void>> deleteProduct(DeleteParams args) {
    return super.delete(args);
  }

  @override
  Future<Either<RequestError, int>> getAllProductsCount() {
    return super.getAllCount();
  }

  @override
  Future<Either<RequestError, Product>> getProduct(String id) {
    return super.get(id, Product.fromEmpty());
  }

  @override
  Future<Either<RequestError, List<Product>>> getProducts(GetAllParams args) {
    return super.getAll(args, Product.fromEmpty());
  }

  @override
  Future<Either<RequestError, void>> updateProduct(
      UpdateProductParams args) async {
    try {
      return Right(await db.update(tableName, args));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }
}
