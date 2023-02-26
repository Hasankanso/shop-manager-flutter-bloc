import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/common_params/responses/get_all_response.dart';
import 'package:shop_manager/domain/sell/entities/sell.dart';
import 'package:shop_manager/domain/sell/repositories/sell_repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';
import 'package:use_case/use_case.dart';

class GetAllSellCase
    extends UseCase<Either<RequestError, GetAllResponse<Sell>>> {
  final SellRepositoryInterface repo;

  GetAllSellCase(this.repo);

  @override
  FutureOr<Either<RequestError, GetAllResponse<Sell>>> execute(
      GetAllParams args) async {
    List<Sell> items = [];
    int absoluteCount = 0;
    Left<RequestError, GetAllResponse<Sell>>? error;

    (await repo.getAllSales(args))
        .fold((RequestError l) => error = Left(l), (r) => items = r);
    (await repo.getAllCount())
        .fold((RequestError l) => error = Left(l), (r) => absoluteCount = r);

    if (error != null) {
      return error ?? Left(RequestError("Unknown error"));
    } else {
      return Right(GetAllResponse<Sell>(items, absoluteCount));
    }
  }

  @override
  String get id => "GetAllSellCase";
}
