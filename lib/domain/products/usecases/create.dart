import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/prices/entities/price.dart';
import 'package:shop_manager/domain/prices/prices_repo_interface.dart';
import 'package:shop_manager/domain/products/entities/product.dart';
import 'package:shop_manager/domain/products/repositories/repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';
import 'package:use_case/use_case.dart';
import 'package:uuid/uuid.dart';

class CreateProductCase implements UseCase<Either<RequestError, void>> {
  final ProductRepoInterface repo;
  final PriceRepoInterface priceRepo;
  const CreateProductCase(this.repo, this.priceRepo);

  @override
  Future<Either<RequestError, void>> execute(Map<String, dynamic>? args) async {
    args ??= {};

    Product p = args['product'] as Product;

    Price newPrice = Price(
      id: const Uuid().v4(),
      productId: p.id,
      price: p.price,
      cost: p.cost,
      createdAt: DateTime.now(),
    );
    await priceRepo.createPrice(newPrice);

    p.priceId = newPrice.id;

    return repo.createProduct(p);
  }

  @override
  String get id => 'CreateProductCase';
}
