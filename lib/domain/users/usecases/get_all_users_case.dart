import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/domain/users/repositories/user_repo_interface.dart';
import 'package:shop_manager/domain/users/repositories/params/get_all_users_params.dart';
import 'package:shop_manager/domain/utils/request_error.dart';
import 'package:use_case/use_case.dart';

class GetAllUsersCase
    extends UseCase<Either<RequestError, GetAllUsersResponse>> {
  final UserRepoInterface repo;

  GetAllUsersCase(this.repo);

  @override
  FutureOr<Either<RequestError, GetAllUsersResponse>> execute(
      GetAllUsersParams args) async {
    List<User> users = [];
    int absoluteCount = 0;
    Left<RequestError, GetAllUsersResponse>? error;

    (await repo.getUsers(args))
        .fold((RequestError l) => error = Left(l), (r) => users = r);
    (await repo.getAllUsersCount())
        .fold((RequestError l) => error = Left(l), (r) => absoluteCount = r);

    if (error != null) {
      return error ?? Left(RequestError("Unknown error"));
    } else {
      return Right(GetAllUsersResponse(users, absoluteCount));
    }
  }

  @override
  String get id => "GetAllUsersCase";
}

class GetAllUsersResponse {
  final List<User> users;
  final int absoluteCount;

  GetAllUsersResponse(this.users, this.absoluteCount);
}
