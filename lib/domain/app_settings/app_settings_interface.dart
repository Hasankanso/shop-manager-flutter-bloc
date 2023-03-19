import 'dart:ui';

abstract class AppSettingInterface {
  void initialize();

  Future<void> storeLanguage(Locale locale);
  Future<Locale> getLanguage();

  Future<void> storeRememberMe(bool rememberMe);
  Future<bool> getRememberMe();

  Future<void> storeUsername(String username);
  Future<String> getUsername();

  Future<void> storePassword(String password);
  Future<String> getPassword();
}
