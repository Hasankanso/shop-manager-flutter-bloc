import 'package:dartz/dartz.dart';
import 'package:shop_manager/data/common/repo.dart';
import 'package:shop_manager/domain/prices/entities/price.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/prices/prices_repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

class PriceRepo extends CommonRepo<Price> implements PriceRepoInterface {
  PriceRepo({required db}) : super(db: db, tableName: 'prices');

  @override
  Future<void> createPrice(Price price) {
    return super.create(price);
  }

  //create a function to retrieve latest price of a product
  @override
  Future<Either<RequestError, Price>> getLatestPrice(String productId) async {
    List<Price> response = await db.select<Price>(
        tableName,
        "WHERE product_id= $productId ORDER BY created_at DESC LIMIT 1",
        Price.fromEmpty(),
        {"product_id": productId});

    if (response.isEmpty) {
      return Left(
          RequestError.fromHttp(message: "Item not found", statusCode: 404));
    }

    return Right(response[0]);
  }

  @override
  Future<Either<RequestError, List<Price>>> getPrices(GetAllParams params) {
    return super.getAll(params, Price.fromEmpty());
  }
}
