import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:shop_manager/data/data_infra/interfaces/db_interface.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/sell/entities/sell.dart';
import 'package:shop_manager/domain/sell/repositories/params/update_sell_params.dart';
import 'package:shop_manager/domain/sell/repositories/sell_repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

class SellRepository extends SellRepositoryInterface {
  final DBInterface db;
  final String tableName = "sells";

  SellRepository({required this.db});

  @override
  Future<Either<RequestError, void>> create(Sell item) async {
    try {
      return Right(db.insert(tableName, item));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<RequestError, Sell>> get(String id) async {
    try {
      Sell item = (await db.select<Sell>(
          tableName, "WHERE id= $id LIMIT 1", Sell(id: ''), {"id": id}))[0];
      return Right(item);
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureOr<Either<RequestError, int>> getAllCount() async {
    try {
      var response = await db.query("SELECT COUNT(*) FROM $tableName");
      return Right(int.parse(response[0]["COUNT(*)"]));
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
  Future<Either<RequestError, List<Sell>>> getAll(GetAllParams args) async {
    int page = (args.page - 1) * args.perPage;
    var response = await db.select<Sell>(
        tableName,
        "LIMIT ${args.perPage * 2} OFFSET $page",
        Sell(id: ''),
        {"page": args.perPage});

    if (response.isEmpty) {
      return Left(
          RequestError.fromHttp(message: "No item found", statusCode: 404));
    }

    return Right(response);
  }

  @override
  Future<Either<RequestError, void>> update(UpdateSellParams args) async {
    try {
      return Right(db.update(tableName, args));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }
}
