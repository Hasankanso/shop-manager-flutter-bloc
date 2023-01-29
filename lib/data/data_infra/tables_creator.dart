import 'package:shop_manager/data/data_infra/interfaces/db_interface.dart';

class CreateTables {
  DBInterface db;

  CreateTables({required this.db});

  Future<void> createAll() async {
    await db.query("CREATE TABLE IF NOT EXISTS users ("
        "id VARCHAR(255) PRIMARY KEY,"
        "firstName VARCHAR(255),"
        "lastName VARCHAR(255),"
        "position VARCHAR(255)"
        ")");
    await db.query("CREATE TABLE IF NOT EXISTS products ("
        "id VARCHAR(255) PRIMARY KEY,"
        "name VARCHAR(255),"
        "price DOUBLE,"
        "quantity INT,"
        "description VARCHAR(255),"
        "image VARCHAR(255)"
        ")");
    await db.query("CREATE TABLE IF NOT EXISTS customers ("
        "id VARCHAR(255) PRIMARY KEY,"
        "firstName VARCHAR(255),"
        "lastName VARCHAR(255),"
        "phone VARCHAR(255),"
        "email VARCHAR(255),"
        "address VARCHAR(255)"
        ")");
    await db.query("CREATE TABLE IF NOT EXISTS suppliers ("
        "id VARCHAR(255) PRIMARY KEY,"
        "name VARCHAR(255),"
        "phone VARCHAR(255),"
        "email VARCHAR(255),"
        "address VARCHAR(255)"
        ")");
  }
}
