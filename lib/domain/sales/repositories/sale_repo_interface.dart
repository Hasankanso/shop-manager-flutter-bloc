import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/sales/entities/sale.dart';
import 'package:shop_manager/domain/sales/repositories/params/update_sale_params.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

abstract class SaleRepositoryInterface {
  Future<Either<RequestError, Sale>> getSale(String id);
  Future<Either<RequestError, List<Sale>>> getAllSales(GetAllParams args);
  Future<Either<RequestError, void>> create(Sale item);
  Future<Either<RequestError, void>> updateSale(UpdateSaleParams args);
  Future<Either<RequestError, void>> delete(DeleteParams args);

  FutureOr<Either<RequestError, int>> getAllCount();
}
