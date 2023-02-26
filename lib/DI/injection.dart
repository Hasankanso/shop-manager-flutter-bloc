import 'package:get_it/get_it.dart';
import 'package:shop_manager/data/data_infra/interfaces/db_interface.dart';
import 'package:shop_manager/data/data_infra/local_mysql.dart';
import 'package:shop_manager/data/products/repo.dart';
import 'package:shop_manager/data/sell/sell_repo.dart';
import 'package:shop_manager/data/users/user_repo.dart';
import 'package:shop_manager/domain/products/repositories/repo_interface.dart';
import 'package:shop_manager/domain/products/usecases/create.dart';
import 'package:shop_manager/domain/products/usecases/get_all.dart';
import 'package:shop_manager/domain/products/usecases/sell.dart';
import 'package:shop_manager/domain/sell/repositories/sell_repo_interface.dart';
import 'package:shop_manager/domain/sell/usecases/delete_sell_case.dart';
import 'package:shop_manager/domain/sell/usecases/get_sell_case.dart';
import 'package:shop_manager/domain/sell/usecases/update_sell_case.dart';
import 'package:shop_manager/domain/users/repositories/user_repo_interface.dart';
import 'package:shop_manager/domain/users/usecases/create_user_case.dart';
import 'package:shop_manager/domain/users/usecases/get_all_users_case.dart';

class DI {
  final getIt = GetIt.instance;

  Future<void> initialize() async {
    getIt.registerSingleton<DBInterface>(MySQLDB());
    var db = getIt.get<DBInterface>();

    getIt.registerSingleton<UserRepoInterface>(UserRepository(db: db));
    var userRepo = getIt.get<UserRepoInterface>();
    getIt.registerFactory(() => GetAllUsersCase(userRepo));
    getIt.registerFactory(() => CreateUserCase(userRepo));

    getIt.registerSingleton<SellRepositoryInterface>(SellRepository(db: db));
    var sellRepo = getIt.get<SellRepositoryInterface>();
    getIt.registerFactory(() => GetAllSellCase(sellRepo));
    getIt.registerFactory(() => UpdateSellCase(sellRepo));
    getIt.registerFactory(() => DeleteSellCase(sellRepo));

    getIt
        .registerFactory<ProductRepoInterface>(() => ProductRepository(db: db));
    var productRepo = getIt.get<ProductRepoInterface>();
    getIt.registerFactory(() => GetAllProductsCase(productRepo));
    getIt.registerFactory(
        () => SellProductCase(productRepo: productRepo, sellRepo: sellRepo));
    getIt.registerFactory(() => CreateProductCase(productRepo));
  }
}
