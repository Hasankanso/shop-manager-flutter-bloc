import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shop_manager/data/common/repo_interface.dart';
import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';
import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/data/data_infra/interfaces/db_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

class CommonRepo<T> implements CommonRepoInterface<T> {
  final DBInterface db;
  final String tableName;

  CommonRepo({required this.db, required this.tableName});

  @override
  Future<Either<RequestError, T>> get(String id, Table factory) async {
    List<T> response = await db
        .select<T>(tableName, "WHERE id= $id LIMIT 1", factory, {"id": id});

    if (response.isEmpty) {
      return Left(
          RequestError.fromHttp(message: "Item not found", statusCode: 404));
    }

    return Right(response[0]);
  }

  @override
  Future<Either<RequestError, void>> create(T item) async {
    try {
      return Right(await db.insert(tableName, item as Table));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<RequestError, void>> delete(DeleteParams args) async {
    try {
      return Right(await db.delete(tableName, args.id));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<RequestError, List<T>>> getAll(
      GetAllParams args, Table factory) async {
    int page = (args.page - 1) * args.perPage;

    try {
      var response = await db.select<T>(
          tableName,
          "LIMIT ${args.perPage * 2} OFFSET $page",
          factory,
          {"page": args.perPage});
      return Right(response);
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<RequestError, void>> update(T item) async {
    try {
      return Right(await db.update(tableName, item as Table));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<RequestError, int>> getAllCount() async {
    try {
      var response = await db.query("SELECT COUNT(*) FROM $tableName");
      return Right(int.parse(response[0]["COUNT(*)"]));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }
}
