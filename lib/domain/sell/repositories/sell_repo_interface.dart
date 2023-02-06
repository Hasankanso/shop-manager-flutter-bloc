import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/sell/entities/sell.dart';
import 'package:shop_manager/domain/sell/repositories/params/update_sell_params.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

abstract class SellRepositoryInterface {
  Future<Either<RequestError, Sell>> get(String id);
  Future<Either<RequestError, List<Sell>>> getAll(GetAllParams args);
  Future<Either<RequestError, void>> create(Sell item);
  Future<Either<RequestError, void>> update(UpdateSellParams args);
  Future<Either<RequestError, void>> delete(DeleteParams args);

  FutureOr<Either<RequestError, int>> getAllCount();
}
