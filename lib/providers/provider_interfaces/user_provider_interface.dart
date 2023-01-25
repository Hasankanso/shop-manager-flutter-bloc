import 'package:shop_manager/providers/provider_interfaces/table_provider_interface.dart';

abstract class UserProviderInterface extends TableProviderInterface {
  bool login(String username, String password);
  void getUsers();
}
