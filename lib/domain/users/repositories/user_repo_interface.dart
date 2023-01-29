import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/domain/users/usecases/params/get_all_users_params.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

abstract class UserRepoInterface {
  Future<Either<RequestError, User>> getUser(String id);
  Future<Either<RequestError, List<User>>> getUsers(GetAllUsersParams args);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}
