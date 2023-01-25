import 'package:equatable/equatable.dart';
import 'package:shop_manager/data_objects/user.dart';
import 'package:shop_manager/providers/table/table_state.dart';

class UserModuleState extends TableState implements Equatable {
  final List<User> users;
  final User? currentUser;
  final bool isLoading;

  const UserModuleState(this.currentUser,
      {this.users = const [], page = 1, pageSize = 10, this.isLoading = true})
      : super(page: page, pageSize: pageSize);

  UserModuleState setPage(int page) {
    return UserModuleState(currentUser,
        users: users, page: page, pageSize: pageSize, isLoading: isLoading);
  }

  UserModuleState setPageSize(int pageSize) {
    return UserModuleState(currentUser,
        users: users, page: page, pageSize: pageSize, isLoading: isLoading);
  }

  @override
  List<Object?> get props => [currentUser, page, pageSize, isLoading, ...users];
}
