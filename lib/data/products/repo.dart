import 'package:shop_manager/data/common/repo.dart';
import 'package:shop_manager/data/common/utils.dart';
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
  Future<Either<RequestError, int>> getAllProductsCount(
      {Map<String, dynamic>? containsFilter}) {
    return super.getAllCount(containsFilter: containsFilter);
  }

  @override
  Future<Either<RequestError, Product>> getProduct(String id) {
    return super.get(id, Product.fromEmpty());
  }

  @override
  Future<Either<RequestError, List<Product>>> getProducts(
      GetAllParams args) async {
    int page = (args.page - 1) * args.perPage;
    try {
      var response = await db.select<Product>(
          tableName,
          "JOIN prices ON products.id=prices.productId "
          "WHERE products.deletedAt is NULL AND prices.deletedAt is NULL "
          "ORDER BY prices.createdAt DESC LIMIT ${args.perPage * 2} OFFSET $page",
          Product.fromEmpty(),
          {},
          columnNames:
              "products.*, prices.price as price, prices.cost as cost");

      return Right(response);
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
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
