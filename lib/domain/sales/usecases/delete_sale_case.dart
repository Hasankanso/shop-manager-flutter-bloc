import 'dart:async';

import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/sales/repositories/sale_repo_interface.dart';
import 'package:use_case/use_case.dart';

class DeleteSaleCase extends UseCase<void> {
  final SaleRepositoryInterface repository;

  DeleteSaleCase(this.repository);

  @override
  String get id => 'DeleteSaleCase';

  @override
  FutureOr<void> execute(covariant Object? args) {
    repository.delete(args as DeleteParams);
  }
}
