import 'dart:async';
import 'package:shop_manager/domain/sell/entities/sell.dart';
import 'package:shop_manager/domain/sell/repositories/sell_repo_interface.dart';
import 'package:use_case/use_case.dart';

class CreateSellCase implements UseCase<int> {
  final SellRepositoryInterface repo;

  const CreateSellCase(this.repo);

  @override
  FutureOr<int> execute(Map<String, dynamic>? args) {
    args ??= {};

    try {
      repo.create(args['user'] as Sell);
      return 0;
    } catch (e) {
      return -1;
    }
  }

  @override
  String get id => 'CreateSellCase';
}
