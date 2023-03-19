import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_manager/domain/app_settings/app_settings_interface.dart';
import 'package:shop_manager/presentations/app_settings/states/app_setting_state.dart';

class AppSettingBloc extends Cubit<AppSettingState> {
  final GetIt di;
  late final AppSettingInterface storage;

  AppSettingBloc(this.di) : super(AppSettingState()) {
    storage = di.get<AppSettingInterface>();
  }

  Future<void> initialize() async {
    emit(state.copyWith(status: AppSettingStatus.loading));

    try {
      final language = await storage.getLanguage();
      final rememberMe = await storage.getRememberMe();
      final username = await storage.getUsername();
      final password = await storage.getPassword();
      emit(state.copyWith(
          language: language,
          rememberMe: rememberMe,
          username: username,
          password: password,
          error: null,
          status: AppSettingStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AppSettingStatus.error, error: e.toString()));
    }
  }
}
