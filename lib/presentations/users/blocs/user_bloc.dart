import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/domain/users/usecases/create_user_case.dart';
import 'package:shop_manager/domain/users/usecases/get_all_users_case.dart';
import 'package:shop_manager/presentations/users/blocs/interfaces/user_bloc_interface.dart';
import 'package:shop_manager/presentations/users/states/users_state.dart';

class UserBloc extends UserBlocInterface {
  late final CreateUserCase createUserCase;
  late final GetAllUsersCase getAllUsersCase;
  final GetIt di;

  UserBloc(this.di) : super(const UserState(users: [])) {
    createUserCase = di.get<CreateUserCase>();
    getAllUsersCase = di.get<GetAllUsersCase>();
  }

  @override
  Future<void> getUsers() async {
    var response = await getAllUsersCase
        .execute(GetAllParams(page: 1, pageSize: state.pageSize));

    response.fold(
        (l) => emit(state.copyWith(
            status: UserStatus.error, errorMessage: l.message.i18n())),
        (response) => emit(state.copyWith(
            currentUser: state.currentUser,
            users: response.users,
            status: UserStatus.loaded,
            usersAbsoluteCount: response.absoluteCount)));
  }

  @override
  Future<void> createUser(User user) async {
    (await createUserCase.execute({"user": user})).fold(
        (l) => emit(state.copyWith(
            status: UserStatus.error, errorMessage: l.message.i18n())),
        (r) => emit(state.copyWith(
            currentUser: state.currentUser,
            users: state.users,
            status: UserStatus.loaded,
            usersAbsoluteCount: state.usersAbsoluteCount)));
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
