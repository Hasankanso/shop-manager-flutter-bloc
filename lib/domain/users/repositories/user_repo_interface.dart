import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/domain/users/repositories/params/get_all_users_params.dart';
import 'package:shop_manager/domain/users/repositories/params/update_user_params.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

abstract class UserRepoInterface {
  Future<Either<RequestError, User>> getUser(String id);
  Future<Either<RequestError, List<User>>> getUsers(GetAllUsersParams args);
  Future<Either<RequestError, void>> createUser(User user);
  Future<Either<RequestError, void>> updateUser(UpdateUserParams args);
  Future<Either<RequestError, void>> deleteUser(DeleteParams args);

  FutureOr<Either<RequestError, int>> getAllUsersCount();
}
