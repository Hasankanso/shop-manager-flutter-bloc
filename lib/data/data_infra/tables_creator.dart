import 'package:shop_manager/data/data_infra/interfaces/db_interface.dart';
import 'package:uuid/uuid.dart';

class CreateTables {
  DBInterface db;

  CreateTables({required this.db});

  Future<void> createAll() async {
    await db.query("CREATE TABLE IF NOT EXISTS users ("
        "id VARCHAR(255) PRIMARY KEY,"
        "firstName VARCHAR(255),"
        "lastName VARCHAR(255),"
        "position VARCHAR(255),"
        "password VARCHAR(255),"
        "username VARCHAR(255),"
        "createdAt DATETIME DEFAULT NOW(),"
        "deletedAt DATETIME,"
        "updatedAt DATETIME"
        ")");

    await db.query("CREATE TABLE IF NOT EXISTS products ("
        "id VARCHAR(255) PRIMARY KEY,"
        "name VARCHAR(255),"
        "category VARCHAR(255),"
        "quantity INT,"
        "priceId VARCHAR(255),"
        "description VARCHAR(255),"
        "image VARCHAR(255),"
        "barcode VARCHAR(255),"
        "createdAt DATETIME DEFAULT NOW(),"
        "deletedAt DATETIME,"
        "updatedAt DATETIME"
        ")");

    await db.query("CREATE TABLE IF NOT EXISTS prices ("
        "id VARCHAR(255) PRIMARY KEY,"
        "productId VARCHAR(255),"
        "price DOUBLE,"
        "cost DOUBLE,"
        "createdAt DATETIME DEFAULT NOW(),"
        "deletedAt DATETIME,"
        "updatedAt DATETIME"
        ")");

    await db.query("CREATE TABLE IF NOT EXISTS exchange_rates ("
        "id VARCHAR(255) PRIMARY KEY,"
        "rate DOUBLE,"
        "fromCurrency VARCHAR(255),"
        "toCurrency VARCHAR(255),"
        "exchangeDate DATETIME,"
        "createdAt DATETIME DEFAULT NOW(),"
        "deletedAt DATETIME,"
        "updatedAt DATETIME"
        ")");

    await db.query("CREATE TABLE IF NOT EXISTS currencies("
        "id VARCHAR(255) PRIMARY KEY,"
        "name VARCHAR(255),"
        "code VARCHAR(255),"
        "symbol VARCHAR(255),"
        "createdAt DATETIME DEFAULT NOW(),"
        "deletedAt DATETIME,"
        "updatedAt DATETIME"
        ")");
    var response = await db.query("SELECT * FROM currencies");

    if (response.length != 3) {
      String id1 = const Uuid().v4();
      db.query(
          "INSERT INTO currencies (id, name, code, symbol) VALUES ($id1, 'Dollar', 'USD', '\$')");
      String id2 = const Uuid().v4();
      db.query(
          "INSERT INTO currencies (id, name, code, symbol) VALUES ($id2, 'Euro', 'EUR', '€')");
      String id3 = const Uuid().v4();
      db.query(
          "INSERT INTO currencies (id, name, code, symbol) VALUES ($id3, 'Libanese Lira', 'LBP', 'ل.ل.')");
    }

    await db.query("CREATE TABLE IF NOT EXISTS categories ("
        "id VARCHAR(255) PRIMARY KEY,"
        "name VARCHAR(255),"
        "createdAt DATETIME DEFAULT NOW(),"
        "deletedAt DATETIME,"
        "updatedAt DATETIME"
        ")");
    await db.query("CREATE TABLE IF NOT EXISTS customers ("
        "id VARCHAR(255) PRIMARY KEY,"
        "firstName VARCHAR(255),"
        "lastName VARCHAR(255),"
        "phone VARCHAR(255),"
        "email VARCHAR(255),"
        "address VARCHAR(255),"
        "createdAt DATETIME DEFAULT NOW(),"
        "deletedAt DATETIME,"
        "updatedAt DATETIME"
        ")");

    await db.query("CREATE TABLE IF NOT EXISTS suppliers ("
        "id VARCHAR(255) PRIMARY KEY,"
        "name VARCHAR(255),"
        "phone VARCHAR(255),"
        "email VARCHAR(255),"
        "address VARCHAR(255),"
        "createdAt DATETIME DEFAULT NOW(),"
        "deletedAt DATETIME,"
        "updatedAt DATETIME"
        ")");

    await db.query("CREATE TABLE IF NOT EXISTS sales ("
        "id VARCHAR(255) PRIMARY KEY,"
        "productId VARCHAR(255),"
        "productCost VARCHAR(255),"
        "productPrice VARCHAR(255),"
        "productQuantity INT,"
        "productDiscount VARCHAR(255),"
        "customerId VARCHAR(255),"
        "userId VARCHAR(255),"
        "createdAt DATETIME DEFAULT NOW(),"
        "deletedAt DATETIME,"
        "updatedAt DATETIME"
        ")");

    // try {
    //   await db.insert(
    //       'sells',
    //       Sell(
    //           id: '1',
    //           customerId: '1',
    //           userId: '1',
    //           createdAt: DateTime.now(),
    //           productCost: '2',
    //           productPrice: '5000',
    //           productQuantity: 4));

    //   await db.insert(
    //       'sells',
    //       Sell(
    //           id: '2',
    //           customerId: '1',
    //           userId: '1',
    //           createdAt: DateTime.now(),
    //           productCost: '2',
    //           productPrice: '7000',
    //           productQuantity: 4));
    // } catch (e) {
    //   print(e);
    // }
  }
}
