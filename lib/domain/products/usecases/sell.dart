import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/customers/customer.dart';
import 'package:shop_manager/domain/persons/entities/person.dart';
import 'package:shop_manager/domain/products/entities/product.dart';
import 'package:shop_manager/domain/products/repositories/params/update.dart';
import 'package:shop_manager/domain/products/repositories/repo_interface.dart';
import 'package:shop_manager/domain/sales/entities/sale.dart';
import 'package:shop_manager/domain/sales/repositories/sale_repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';
import 'package:use_case/use_case.dart';
import 'package:uuid/uuid.dart';

class SellProductCase implements UseCase<Either<RequestError, void>> {
  final ProductRepoInterface productRepo;
  final SaleRepositoryInterface saleRepo;
  const SellProductCase({required this.productRepo, required this.saleRepo});

  @override
  Future<Either<RequestError, void>> execute(Map<String, dynamic>? args) async {
    args ??= {};
    Product product = args['product'] as Product;
    double price = args['price'] as double;
    Object? customerObj = args['customer'];
    Customer? customer;
    if (customerObj != null) {
      customer = customerObj as Customer;
    }
    Person? user = args['user'] as Person;
    int quantity = args['quantity'] as int;
    if (quantity > product.quantity) {
      return Left(RequestError("Required Quantity is not available".i18n()));
    }

    Left<RequestError, void>? error;

    var prodResponse = await productRepo.updateProduct(UpdateProductParams(
        id: product.id, quantity: product.quantity - quantity));

    prodResponse.fold((l) => error = Left(l), (r) {});

    if (error == null) {
      await saleRepo
          .create(Sale(
              id: const Uuid().v4(),
              productId: product.id,
              productCost: product.cost,
              productDiscount: (product.price - price) / product.price,
              productQuantity: quantity,
              customerId: customer?.id,
              productPrice: price,
              userId: user.id))
          .then((value) => value.fold((l) => error = Left(l), (r) {}));
    }

    return error ?? const Right(null);
  }

  @override
  String get id => 'CreateProductCase';
}
