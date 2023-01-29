import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/persons/entities/person.dart';
import 'package:shop_manager/data/data_infra/interfaces/db_interface.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/domain/users/repositories/user_repo_interface.dart';
import 'package:shop_manager/domain/users/usecases/params/get_all_users_params.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

class UserRepository implements UserRepoInterface {
  late final DBInterface db;
  String tableName = "users";
  UserRepository({required this.db});

  @override
  Future<Either<RequestError, User>> getUser(String id) async {
    List<User> users = await db
        .select<User>(tableName, "WHERE id= $id LIMIT 1", Person(), {"id": id});

    if (users.isEmpty) {
      return Left(
          RequestError.fromHttp(message: "User not found", statusCode: 404));
    }

    return Right(users[0]);
  }

  @override
  Future<void> createUser(User user) {
    return db.insert(tableName, user);
  }

  @override
  Future<void> deleteUser(String id) async {
    return await db.delete(tableName, id);
  }

  @override
  Future<Either<RequestError, List<User>>> getUsers(
      GetAllUsersParams args) async {
    int page = (args.page - 1) * args.perPage;
    var response = await db.select<User>(
        tableName,
        "LIMIT ${args.perPage * 2} OFFSET $page",
        User(),
        {"page": args.perPage});

    if (response.isEmpty) {
      return Left(
          RequestError.fromHttp(message: "No users found", statusCode: 404));
    }

    return Right(response);
  }

  @override
  Future<void> updateUser(User user) {
    return db.update(tableName, user);
  }
}
