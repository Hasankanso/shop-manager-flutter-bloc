import 'package:get_it/get_it.dart';
import 'package:shop_manager/data/data_infra/interfaces/db_interface.dart';
import 'package:shop_manager/data/data_infra/local_mysql.dart';
import 'package:shop_manager/data/products/repo.dart';
import 'package:shop_manager/data/sales/sale_repo.dart';
import 'package:shop_manager/data/users/user_repo.dart';
import 'package:shop_manager/domain/products/repositories/repo_interface.dart';
import 'package:shop_manager/domain/products/usecases/create.dart';
import 'package:shop_manager/domain/products/usecases/get_all.dart';
import 'package:shop_manager/domain/products/usecases/sell.dart';
import 'package:shop_manager/domain/sales/repositories/sale_repo_interface.dart';
import 'package:shop_manager/domain/sales/usecases/delete_sale_case.dart';
import 'package:shop_manager/domain/sales/usecases/get_sale_case.dart';
import 'package:shop_manager/domain/sales/usecases/update_sale_case.dart';
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

    getIt.registerSingleton<SaleRepositoryInterface>(SaleRepository(db: db));
    var saleRepo = getIt.get<SaleRepositoryInterface>();
    getIt.registerFactory(() => GetAllSaleCase(saleRepo));
    getIt.registerFactory(() => UpdateSaleCase(saleRepo));
    getIt.registerFactory(() => DeleteSaleCase(saleRepo));

    getIt
        .registerFactory<ProductRepoInterface>(() => ProductRepository(db: db));
    var productRepo = getIt.get<ProductRepoInterface>();
    getIt.registerFactory(() => GetAllProductsCase(productRepo));
    getIt.registerFactory(
        () => SellProductCase(productRepo: productRepo, saleRepo: saleRepo));
    getIt.registerFactory(() => CreateProductCase(productRepo));
  }
}
