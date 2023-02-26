import 'package:shop_manager/data/data_infra/interfaces/db_interface.dart';

class CreateTables {
  DBInterface db;

  CreateTables({required this.db});

  Future<void> createAll() async {
    await db.query("CREATE TABLE IF NOT EXISTS users ("
        "id VARCHAR(255) PRIMARY KEY,"
        "firstName VARCHAR(255),"
        "lastName VARCHAR(255),"
        "position VARCHAR(255),"
        "isDeleted BOOLEAN DEFAULT 1,"
        "createdAt DATETIME DEFAULT NOW(),"
        "deletedAt DATETIME,"
        "updatedAt DATETIME"
        ")");

    await db.query("CREATE TABLE IF NOT EXISTS products ("
        "id VARCHAR(255) PRIMARY KEY,"
        "name VARCHAR(255),"
        "price DOUBLE,"
        "cost DOUBLE,"
        "category VARCHAR(255),"
        "quantity INT,"
        "description VARCHAR(255),"
        "image VARCHAR(255),"
        "isDeleted BOOLEAN DEFAULT 0,"
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
        "isDeleted BOOLEAN DEFAULT 0,"
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
        "isDeleted BOOLEAN DEFAULT 0,"
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
        "isDeleted BOOLEAN DEFAULT 0,"
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
