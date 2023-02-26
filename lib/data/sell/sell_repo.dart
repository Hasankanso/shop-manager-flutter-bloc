import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:shop_manager/data/common/repo.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/sell/entities/sell.dart';
import 'package:shop_manager/domain/sell/repositories/params/update_sell_params.dart';
import 'package:shop_manager/domain/sell/repositories/sell_repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

class SellRepository extends CommonRepo<Sell>
    implements SellRepositoryInterface {
  SellRepository({required db}) : super(tableName: "sells", db: db);

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
  Future<Either<RequestError, Sell>> getSale(String id) async {
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
  Future<Either<RequestError, int>> getAllCount() async {
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
  Future<Either<RequestError, List<Sell>>> getAllSales(
      GetAllParams args) async {
    return super.getAll(args, Sell(id: ''));
  }

  @override
  Future<Either<RequestError, void>> updateSale(UpdateSellParams args) async {
    try {
      return Right(db.update(tableName, args));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }
}
