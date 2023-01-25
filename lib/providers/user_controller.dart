import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_manager/data_objects/user.dart';
import 'package:shop_manager/repository/interfaces/user_repo_interface.dart';
import 'package:uuid/uuid.dart';

class UserController extends Cubit<User> {
  UserRepoInterface repo;

  UserController(this.repo)
      : super(User(
            id: "id",
            firstName: "FirstName",
            lastName: "lastName",
            position: "root"));

  void initialize(
    id,
    firstName,
    lastName,
    position,
  ) =>
      emit(User(
          id: id,
          firstName: firstName,
          lastName: lastName,
          position: position));

  Future<void> createUser(User user) {
    user.id = const Uuid().v4();
    return repo.createUser(user);
  }
}
