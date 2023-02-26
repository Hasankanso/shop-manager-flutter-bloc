import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_manager/domain/persons/entities/person.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/domain/users/repositories/user_repo_interface.dart';
import 'package:uuid/uuid.dart';

class AuthBloc extends Cubit<Person?> {
  UserRepoInterface repo;

  AuthBloc(this.repo)
      : super(Person(
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
      emit(Person(
          id: id,
          firstName: firstName,
          lastName: lastName,
          position: position));

  Future<void> createUser(User user) {
    user = user.copyWith(id: const Uuid().v4());
    return repo.createUser(user);
  }
}
