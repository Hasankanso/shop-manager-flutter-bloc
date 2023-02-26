import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/products/entities/product.dart';
import 'package:shop_manager/domain/products/repositories/repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';
import 'package:use_case/use_case.dart';

class GetAllProductsCase
    extends UseCase<Either<RequestError, GetAllProductsResponse>> {
  final ProductRepoInterface repo;

  GetAllProductsCase(this.repo);

  @override
  FutureOr<Either<RequestError, GetAllProductsResponse>> execute(
      GetAllParams args) async {
    List<Product> items = [];
    int absoluteCount = 0;
    Left<RequestError, GetAllProductsResponse>? error;

    (await repo.getProducts(args))
        .fold((RequestError l) => error = Left(l), (r) => items = r);
    (await repo.getAllProductsCount())
        .fold((RequestError l) => error = Left(l), (r) => absoluteCount = r);

    if (error != null) {
      return error ?? Left(RequestError("Unknown error"));
    } else {
      return Right(GetAllProductsResponse(items, absoluteCount));
    }
  }

  @override
  String get id => "GetAllProductsCase";
}

class GetAllProductsResponse {
  final List<Product> users;
  final int absoluteCount;

  GetAllProductsResponse(this.users, this.absoluteCount);
}
