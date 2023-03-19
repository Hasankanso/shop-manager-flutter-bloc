import 'dart:ui';

enum AppSettingStatus { initial, loading, error, success }

class AppSettingState {
  final Locale? language;
  final bool? rememberMe;
  final String? username;
  final String? password;
  final AppSettingStatus status;
  final String? error;

  AppSettingState({
    this.language,
    this.rememberMe,
    this.username,
    this.password,
    this.status = AppSettingStatus.initial,
    this.error,
  });

  AppSettingState copyWith({
    Locale? language,
    bool? rememberMe,
    String? username,
    String? password,
    AppSettingStatus? status,
    String? error,
  }) {
    return AppSettingState(
      language: language ?? this.language,
      rememberMe: rememberMe ?? this.rememberMe,
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
