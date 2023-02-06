import 'dart:async';
import 'package:shop_manager/domain/sell/repositories/params/update_sell_params.dart';
import 'package:shop_manager/domain/sell/repositories/sell_repo_interface.dart';
import 'package:use_case/use_case.dart';

class UpdateSellCase extends UseCase<void> {
  final SellRepositoryInterface repo;

  UpdateSellCase(this.repo);

  @override
  FutureOr<void> execute(covariant Object? args) async {
    await repo.update(args as UpdateSellParams);
  }

  @override
  String get id => 'UpdateSellCase';
}
