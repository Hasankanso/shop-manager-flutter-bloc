import 'dart:async';
import 'package:shop_manager/domain/sales/repositories/params/update_sale_params.dart';
import 'package:shop_manager/domain/sales/repositories/sale_repo_interface.dart';
import 'package:use_case/use_case.dart';

class UpdateSaleCase extends UseCase<void> {
  final SaleRepositoryInterface repo;

  UpdateSaleCase(this.repo);

  @override
  FutureOr<void> execute(covariant Object? args) async {
    await repo.updateSale(args as UpdateSaleParams);
  }

  @override
  String get id => 'UpdateSaleCase';
}
