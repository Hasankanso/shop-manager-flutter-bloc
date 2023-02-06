import 'dart:async';

import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/sell/repositories/sell_repo_interface.dart';
import 'package:use_case/use_case.dart';

class DeleteSellCase extends UseCase<void> {
  final SellRepositoryInterface repository;

  DeleteSellCase(this.repository);

  @override
  String get id => 'DeleteSellCase';

  @override
  FutureOr<void> execute(covariant Object? args) {
    repository.delete(args as DeleteParams);
  }
}
