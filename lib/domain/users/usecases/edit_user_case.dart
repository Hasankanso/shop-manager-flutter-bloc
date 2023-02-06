import 'dart:async';
import 'package:shop_manager/domain/users/repositories/params/update_user_params.dart';
import 'package:shop_manager/domain/users/repositories/user_repo_interface.dart';
import 'package:use_case/use_case.dart';

class EditUserCase extends UseCase<void> {
  final UserRepoInterface _userRepository;

  EditUserCase(this._userRepository);

  @override
  FutureOr<void> execute(covariant Object? args) async {
    await _userRepository.updateUser(args as UpdateUserParams);
  }

  @override
  String get id => 'EditUserCase';
}
