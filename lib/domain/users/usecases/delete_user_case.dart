import 'dart:async';

import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/users/repositories/user_repo_interface.dart';
import 'package:use_case/use_case.dart';

class DeleteUserCase extends UseCase<void> {
  final UserRepoInterface repository;

  DeleteUserCase(this.repository);

  @override
  String get id => 'DeleteUserCase';

  @override
  FutureOr<void> execute(covariant Object? args) {
    repository.deleteUser(args as DeleteParams);
  }
}
