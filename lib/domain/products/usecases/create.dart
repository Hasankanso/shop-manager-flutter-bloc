import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/products/entities/product.dart';
import 'package:shop_manager/domain/products/repositories/repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';
import 'package:use_case/use_case.dart';

class CreateProductCase implements UseCase<Either<RequestError, void>> {
  final ProductRepoInterface repo;

  const CreateProductCase(this.repo);

  @override
  Future<Either<RequestError, void>> execute(Map<String, dynamic>? args) async {
    args ??= {};
    return repo.createProduct(args['product'] as Product);
  }

  @override
  String get id => 'CreateProductCase';
}
