import 'dart:async';

import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/domain/users/repositories/user_repo_interface.dart';
import 'package:use_case/use_case.dart';

class CreateUserCase implements UseCase<int> {
  final UserRepoInterface repo;

  const CreateUserCase(this.repo);

  @override
  FutureOr<int> execute(Map<String, dynamic>? args) {
    args ??= {};

    try {
      repo.createUser(args['user'] as User);
      return 0;
    } catch (e) {
      return -1;
    }
  }

  @override
  String get id => 'CreateUserCase';
}
