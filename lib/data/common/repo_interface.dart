import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';
import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

abstract class CommonRepoInterface<T> {
  Future<Either<RequestError, T>> get(String id, Table factory);

  Future<Either<RequestError, void>> create(T item);

  Future<Either<RequestError, void>> delete(DeleteParams args);

  Future<Either<RequestError, List<T>>> getAll(
      GetAllParams args, Table factory);

  Future<Either<RequestError, void>> update(T user);
  Future<Either<RequestError, int>> getAllCount();
}
