import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/users/usecases/create_user_case.dart';
import 'package:shop_manager/domain/users/usecases/get_all_users_case.dart';
import 'package:shop_manager/domain/users/usecases/params/get_all_users_params.dart';
import 'package:shop_manager/presentations/users/blocs/interfaces/user_bloc_interface.dart';
import 'package:shop_manager/presentations/users/states/users_state.dart';

class UserBloc extends Cubit<UserState> implements UserBlocInterface {
  CreateUserCase createUserCase;
  GetAllUsersCase getAllUsersCase;

  UserBloc(this.createUserCase, this.getAllUsersCase)
      : super(const UserState(users: []));

  @override
  bool login(String username, String password) {
    return false;
  }

  @override
  void getUsers() async {
    var response = await getAllUsersCase
        .execute(GetAllUsersParams(page: 1, pageSize: state.pageSize));

    response.fold(
        (l) => emit(state.copyWith(
            status: UserStatus.error, errorMessage: l.message.i18n())),
        (users) => emit(state.copyWith(
            currentUser: state.currentUser,
            users: users,
            status: UserStatus.loaded)));
  }

  @override
  void nextPage() {
    emit(state.copyWith(page: state.page + 1, status: UserStatus.loading));
    getUsers();
  }

  @override
  void previousPage() {
    emit(state.copyWith(page: state.page - 1, status: UserStatus.loading));
    getUsers();
  }

  @override
  void setPage(int? newPage) {
    emit(state.copyWith(page: newPage ?? 1, status: UserStatus.loading));
    getUsers();
  }

  @override
  void setPageSize(int? newPageSize) {
    emit(state.copyWith(
        pageSize: newPageSize ?? 10, status: UserStatus.loading));
    getUsers();
  }
}
