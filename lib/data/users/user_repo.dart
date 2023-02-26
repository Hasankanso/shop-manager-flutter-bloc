import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/common_params/params/delete_params.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/persons/entities/person.dart';
import 'package:shop_manager/data/data_infra/interfaces/db_interface.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/domain/users/repositories/user_repo_interface.dart';
import 'package:shop_manager/domain/users/repositories/params/update_user_params.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

class UserRepository implements UserRepoInterface {
  late final DBInterface db;
  String tableName = "users";
  UserRepository({required this.db});

  @override
  Future<Either<RequestError, User>> getUser(String id) async {
    List<User> users = await db.select<User>(
        tableName, "WHERE id= $id LIMIT 1", Person(id: ''), {"id": id});

    if (users.isEmpty) {
      return Left(
          RequestError.fromHttp(message: "User not found", statusCode: 404));
    }

    return Right(users[0]);
  }

  @override
  Future<Either<RequestError, void>> createUser(User user) async {
    try {
      return Right(await db.insert(tableName, user));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<RequestError, void>> deleteUser(DeleteParams args) async {
    try {
      return Right(await db.delete(tableName, args.id));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<RequestError, List<User>>> getUsers(GetAllParams args) async {
    int page = (args.page - 1) * args.perPage;
    var response = await db.select<User>(
        tableName,
        "LIMIT ${args.perPage * 2} OFFSET $page",
        User(id: ''),
        {"page": args.perPage});

    if (response.isEmpty) {
      return Left(
          RequestError.fromHttp(message: "No users found", statusCode: 404));
    }

    return Right(response);
  }

  @override
  Future<Either<RequestError, void>> updateUser(UpdateUserParams user) async {
    try {
      return Right(await db.update(tableName, user));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureOr<Either<RequestError, int>> getAllUsersCount() async {
    try {
      var response = await db.query("SELECT COUNT(*) FROM $tableName");
      return Right(int.parse(response[0]["COUNT(*)"]));
    } catch (e) {
      return Left(
          RequestError.fromHttp(message: e.toString(), statusCode: 500));
    }
  }
}
