import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/prices/entities/price.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

abstract class PriceRepoInterface {
  Future<Either<RequestError, List<Price>>> getPrices(GetAllParams params);
  Future<Either<RequestError, Price>> getLatestPrice(String productId);
  Future<void> createPrice(Price price);
}
