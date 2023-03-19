import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/domain/users/entities/user.dart';

enum AuthStatus { initial, noUsers, authenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? error;
  final User? loggedUser;
  final bool rememberMe;
  late final TextEditingController userNameController;
  late final TextEditingController passwordController;

  AuthState({
    this.loggedUser,
    this.status = AuthStatus.initial,
    this.error,
    this.rememberMe = true,
    TextEditingController? userNameController,
    TextEditingController? passwordController,
  }) {
    this.userNameController = userNameController ?? TextEditingController();
    this.passwordController = passwordController ?? TextEditingController();
  }

  @override
  List<Object> get props => [
        status,
        rememberMe.toString(),
        userNameController.text,
        passwordController.text
      ];

  AuthState copyWith({
    AuthStatus? status,
    String? error,
    User? loggedUser,
    bool? rememberMe,
    TextEditingController? userNameController,
    TextEditingController? passwordController,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
      loggedUser: loggedUser ?? this.loggedUser,
      rememberMe: rememberMe ?? this.rememberMe,
      userNameController: userNameController ?? this.userNameController,
      passwordController: passwordController ?? this.passwordController,
    );
  }
}
