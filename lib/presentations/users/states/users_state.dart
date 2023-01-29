import 'package:equatable/equatable.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/presentations/tables/states/table_state.dart';

enum UserStatus { initial, loading, loaded, error }

///states of user modules (get all users create a user etc.)
class UserState extends TableState implements Equatable {
  final List<User> users;
  final User? currentUser;
  final UserStatus status;
  final String? errorMessage;

  const UserState(
      {this.currentUser,
      this.errorMessage,
      this.users = const [],
      page = 1,
      pageSize = 10,
      this.status = UserStatus.initial})
      : super(page: page, pageSize: pageSize);

  UserState copyWith(
      {User? currentUser,
      List<User>? users,
      int? page,
      int? pageSize,
      bool? isLoading,
      UserStatus? status,
      String? errorMessage}) {
    return UserState(
        currentUser: currentUser ?? this.currentUser,
        users: users ?? this.users,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [status, currentUser, page, pageSize, errorMessage, ...users];
}
