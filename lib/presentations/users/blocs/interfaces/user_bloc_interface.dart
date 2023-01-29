import 'package:shop_manager/presentations/tables/states/table_provider_interface.dart';

abstract class UserBlocInterface extends TableProviderInterface {
  bool login(String username, String password);
  void getUsers();
}
