import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/domain/users/repositories/user_repo_interface.dart';
import 'package:shop_manager/domain/utils/request_error.dart';
import 'package:use_case/use_case.dart';

class CreateUserCase implements UseCase<Either<RequestError, int>> {
  final UserRepoInterface repo;

  const CreateUserCase(this.repo);

  @override
  FutureOr<Either<RequestError, int>> execute(
      Map<String, dynamic>? args) async {
    args ??= {};

    try {
      await repo.createUser(args['user'] as User);
      return const Right(0);
    } catch (e) {
      return Left(RequestError(e.toString()));
    }
  }

  @override
  String get id => 'CreateUserCase';
}
