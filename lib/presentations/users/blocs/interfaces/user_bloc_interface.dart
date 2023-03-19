import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/presentations/tables/states/table_provider_interface.dart';
import 'package:shop_manager/presentations/users/states/users_state.dart';

abstract class UserBlocInterface extends Cubit<UserState>
    implements TableProviderInterface {
  UserBlocInterface(UserState initialState) : super(initialState);
  Future<void> getUsers();
  Future<void> createUser(User user);
}
