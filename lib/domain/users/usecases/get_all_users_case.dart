import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/domain/users/repositories/user_repo_interface.dart';
import 'package:shop_manager/domain/users/usecases/params/get_all_users_params.dart';
import 'package:shop_manager/domain/utils/request_error.dart';
import 'package:use_case/use_case.dart';

class GetAllUsersCase extends UseCase<Either<RequestError, List<User>>> {
  final UserRepoInterface repo;

  GetAllUsersCase(this.repo);

  @override
  FutureOr<Either<RequestError, List<User>>> execute(GetAllUsersParams args) {
    return repo.getUsers(args);
  }

  @override
  String get id => "GetAllUsersCase";
}
