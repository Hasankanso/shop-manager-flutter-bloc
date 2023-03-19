import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_manager/domain/auth/usecases/login_case.dart';
import 'package:shop_manager/domain/common_params/params/gel_all_params.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/domain/users/usecases/create_user_case.dart';
import 'package:shop_manager/domain/users/usecases/get_all_users_case.dart';
import 'package:shop_manager/presentations/app_settings/blocs/bloc.dart';
import 'package:shop_manager/presentations/auth/states/auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  late final LoginCase loginCase;
  late final GetAllUsersCase getAllUsersCase;
  late final CreateUserCase createUserCase;
  final AppSettingBloc appSettingBloc;
  final GetIt di;

  AuthBloc(this.di, this.appSettingBloc) : super(AuthState()) {
    loginCase = di.get<LoginCase>();
    getAllUsersCase = di.get<GetAllUsersCase>();
    createUserCase = di.get<CreateUserCase>();
  }

  void switchRememberMe(bool? value) async {
    emit(state.copyWith(rememberMe: value ?? (!state.rememberMe)));
  }

  Future<void> initialize() async {
    var response = await getAllUsersCase.execute(GetAllParams());
    response.fold(
        (l) => emit(state.copyWith(
              status: AuthStatus.error,
              error: l.message,
            )), (r) {
      if (r.absoluteCount == 0) {
        emit(state.copyWith(status: AuthStatus.noUsers));
      } else {
        emit(state.copyWith(
            status: AuthStatus.initial,
            rememberMe: appSettingBloc.state.rememberMe,
            userNameController:
                TextEditingController(text: appSettingBloc.state.username),
            passwordController:
                TextEditingController(text: appSettingBloc.state.password)));
      }
    });
  }

  Future<void> login() async {
    final user = await loginCase.execute(GetAllParams(equalFilter: {
      "username": state.userNameController.text,
      "password": state.passwordController.text
    }));

    bool succeed = false;

    user.fold(
        (l) => emit(state.copyWith(error: l.message, status: AuthStatus.error)),
        (user) {
      succeed = true;
      emit(state.copyWith(status: AuthStatus.authenticated, loggedUser: user));
    });

    if (succeed) {
      appSettingBloc.storage.storeRememberMe(state.rememberMe);

      if (state.rememberMe) {
        appSettingBloc.storage.storeUsername(state.userNameController.text);
        appSettingBloc.storage.storePassword(state.passwordController.text);
      } else {
        appSettingBloc.storage.storeUsername("");
        appSettingBloc.storage.storePassword("");
      }
    }
  }

  Future<void> createRootUser(User user) async {
    var response = await createUserCase.execute({"user": user});
    response.fold(
        (l) => emit(state.copyWith(
            status: AuthStatus.error,
            error: l.message,
            userNameController: TextEditingController(text: user.username),
            passwordController: TextEditingController(text: user.password))),
        (r) async {
      await login();
    });
  }
}
