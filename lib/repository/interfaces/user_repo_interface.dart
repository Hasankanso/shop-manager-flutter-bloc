import 'package:shop_manager/data_objects/user.dart';

abstract class UserRepoInterface {
  Future<User?> getUser(String id);
  Future<List<User>> getUsers({int page, int pageSize = 10});
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}
