import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_manager/providers/provider_interfaces/user_provider_interface.dart';
import 'package:shop_manager/providers/user_module/user_module_state.dart';
import 'package:shop_manager/repository/interfaces/user_repo_interface.dart';

class UserStateProvider extends Cubit<UserModuleState>
    implements UserProviderInterface {
  UserRepoInterface repo;

  UserStateProvider(this.repo)
      : super(const UserModuleState(null, users: [], isLoading: true));

  @override
  bool login(String username, String password) {
    return false;
  }

  @override
  void getUsers() async {
    var users = await repo.getUsers(page: state.page, pageSize: state.pageSize);
    emit(UserModuleState(state.currentUser, users: users, isLoading: false));
  }

  @override
  void nextPage() {
    emit(state.setPage(state.page + 1));
  }

  @override
  void previousPage() {
    emit(state.setPage(state.page - 1));
  }

  @override
  void setPage(int newPage) {
    emit(state.setPage(newPage));
  }

  @override
  void setPageSize(int newPageSize) {
    emit(state.setPageSize(state.page + 1));
  }
}
