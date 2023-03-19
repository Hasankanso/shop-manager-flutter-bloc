import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/domain/users/repositories/user_repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';
import 'package:use_case/use_case.dart';

class LoginCase implements UseCase<Either<RequestError, User>> {
  final UserRepoInterface repo;

  const LoginCase(this.repo);

  @override
  Future<Either<RequestError, User>> execute(GetAllParams args) async {
    var users = await repo.getUsers(args);
    Either<RequestError, User> response = Left(RequestError("Unknown error"));

    users.fold((l) => response = Left(l), (r) {
      if (r.length == 1) {
        response = Right(r[0]);
      } else {
        response = Left(RequestError("Email or password is incorrect"));
      }
    });
    return response;
  }

  @override
  String get id => 'CreateProductCase';
}
