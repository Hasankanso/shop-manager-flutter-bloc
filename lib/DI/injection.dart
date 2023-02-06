import 'package:get_it/get_it.dart';
import 'package:shop_manager/data/data_infra/interfaces/db_interface.dart';
import 'package:shop_manager/data/data_infra/local_mysql.dart';
import 'package:shop_manager/data/sell/sell_repo.dart';
import 'package:shop_manager/data/users/user_repo.dart';
import 'package:shop_manager/domain/sell/usecases/create_sell_case.dart';
import 'package:shop_manager/domain/sell/usecases/delete_sell_case.dart';
import 'package:shop_manager/domain/sell/usecases/get_sell_case.dart';
import 'package:shop_manager/domain/sell/usecases/update_sell_case.dart';
import 'package:shop_manager/domain/users/usecases/create_user_case.dart';
import 'package:shop_manager/domain/users/usecases/get_all_users_case.dart';

class DI {
  final getIt = GetIt.instance;

  Future<void> initialize() async {
    getIt.registerSingleton<DBInterface>(MySQLDB());

    getIt.registerFactory(
        () => GetAllUsersCase(UserRepository(db: getIt.get<DBInterface>())));
    getIt.registerFactory(
        () => CreateUserCase(UserRepository(db: getIt.get<DBInterface>())));

    getIt.registerFactory(
        () => GetAllSellCase(SellRepository(db: getIt.get<DBInterface>())));
    getIt.registerFactory(
        () => CreateSellCase(SellRepository(db: getIt.get<DBInterface>())));
    getIt.registerFactory(
        () => UpdateSellCase(SellRepository(db: getIt.get<DBInterface>())));
    getIt.registerFactory(
        () => DeleteSellCase(SellRepository(db: getIt.get<DBInterface>())));
  }
}
