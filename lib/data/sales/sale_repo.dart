import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:shop_manager/data/common/repo.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/sales/entities/sale.dart';
import 'package:shop_manager/domain/sales/repositories/params/update_sale_params.dart';
import 'package:shop_manager/domain/sales/repositories/sale_repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

class SaleRepository extends CommonRepo<Sale>
    implements SaleRepositoryInterface {
  SaleRepository({required db}) : super(tableName: "sales", db: db);

  @override
  Future<Either<RequestError, void>> create(Sale item) async {
    try {
      return Right(db.insert(tableName, item));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<RequestError, Sale>> getSale(String id) async {
    try {
      Sale item = (await db.select<Sale>(
          tableName, "WHERE id= $id LIMIT 1", Sale(id: ''), {"id": id}))[0];
      return Right(item);
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<RequestError, int>> getAllCount(
      {Map<String, dynamic>? containsFilter}) async {
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
  Future<Either<RequestError, List<Sale>>> getAllSales(
      GetAllParams args) async {
    return super.getAll(args, Sale(id: ''));
  }

  @override
  Future<Either<RequestError, void>> updateSale(UpdateSaleParams args) async {
    try {
      return Right(db.update(tableName, args));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }
}
