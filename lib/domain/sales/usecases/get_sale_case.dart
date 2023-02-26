import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/common_params/responses/get_all_response.dart';
import 'package:shop_manager/domain/sales/entities/sale.dart';
import 'package:shop_manager/domain/sales/repositories/sale_repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';
import 'package:use_case/use_case.dart';

class GetAllSaleCase
    extends UseCase<Either<RequestError, GetAllResponse<Sale>>> {
  final SaleRepositoryInterface repo;

  GetAllSaleCase(this.repo);

  @override
  FutureOr<Either<RequestError, GetAllResponse<Sale>>> execute(
      GetAllParams args) async {
    List<Sale> items = [];
    int absoluteCount = 0;
    Left<RequestError, GetAllResponse<Sale>>? error;

    (await repo.getAllSales(args))
        .fold((RequestError l) => error = Left(l), (r) => items = r);
    (await repo.getAllCount())
        .fold((RequestError l) => error = Left(l), (r) => absoluteCount = r);

    if (error != null) {
      return error ?? Left(RequestError("Unknown error"));
    } else {
      return Right(GetAllResponse<Sale>(items, absoluteCount));
    }
  }

  @override
  String get id => "GetAllSaleCase";
}
