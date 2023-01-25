import 'package:shop_manager/data_objects/user.dart';
import 'package:shop_manager/repository/interfaces/db_interface.dart';

import 'interfaces/user_repo_interface.dart';

class UserRepository implements UserRepoInterface {
  late final DBInterface db;
  String tableName = "users";
  UserRepository({required this.db});

  @override
  Future<User?> getUser(String id) async {
    List<User> users = await db
        .select<User>(tableName, "WHERE id= $id LIMIT 1", User(), {"id": id});

    if (users.isEmpty) {
      return null;
    }

    return users[0];
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
  Future<List<User>> getUsers({int page = 1, int pageSize = 10}) {
    page = (page - 1) * pageSize;

    return db.select<User>(
        tableName, "LIMIT $pageSize OFFSET $page", User(), {"page": pageSize});
  }

  @override
  Future<void> updateUser(User user) {
    return db.update(tableName, user);
  }
}
