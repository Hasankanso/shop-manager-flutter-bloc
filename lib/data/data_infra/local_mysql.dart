import 'package:mysql_client/mysql_client.dart';
import 'package:shop_manager/data/data_infra/interfaces/db_interface.dart';
import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

class MySQLDB implements DBInterface {
  static late final MySQLConnection dbConnection;

  @override
  Future<void> close() {
    return dbConnection.close();
  }

  @override
  Future<void> connect(String host, int port, String username, String password,
      String databaseName) async {
    dbConnection = await MySQLConnection.createConnection(
        host: host,
        port: port,
        userName: username,
        password: password,
        databaseName: databaseName,
        secure: false);

    await dbConnection.connect();
  }

  @override
  Future<void> delete(String table, String id) {
    return dbConnection.execute("DELETE FROM $table WHERE id = $id");
  }

  @override
  Future<void> insert(String table, Table data) {
    Map<String, dynamic> dataMap = data.toJson();
    String insertQuery =
        "INSERT INTO $table (${dataMap.keys.join(",")}) VALUES (${dataMap.values.map((e) => "'$e'").join(",")})";
    return dbConnection.execute(insertQuery);
  }

  @override
  Future<List<Map<String, dynamic>>> query(String query) async {
    var result = await dbConnection.execute(query);
    List<Map<String, dynamic>> list = [];

    for (final row in result.rows) {
      list.add(row.assoc());
    }
    return list;
  }

  @override
  Future<List<T>> select<T>(
      String table, String query, Table builder, Map<String, dynamic>? args,
      {String? columnNames}) async {
    var results = await dbConnection.execute(
        "Select ${columnNames ?? "*"} from $table $query", args);

    List<T> list = [];
    for (final row in results.rows) {
      list.add(builder.fromJson(row.assoc()) as T);
    }
    return list;
  }

  @override
  Future<void> update(String table, Table data) {
    Map<String, dynamic> dataMap = data.toJson();
    String query = "UPDATE $table SET ";
    for (var key in dataMap.keys) {
      dynamic value = dataMap[key];
      if (value != null && key != "id") {
        if (value.toString() == "true") {
          value = "1";
        } else if (value.toString() == "false") {
          value = "0";
        }
        query += "$key = '$value', ";
      }
    }
    query = query.substring(0, query.length - 2);
    query += " WHERE id = '${data.id}'";
    return dbConnection.execute(query);
  }

  @override
  Future<List<Map<String, dynamic>>> rawQuery(
      String query, Map<String, dynamic>? args) async {
    //implement a method to execute raw queries using dbConnection passing the args
    var result = await dbConnection.execute(query, args);

    List<Map<String, dynamic>> list = [];

    for (final row in result.rows) {
      list.add(row.assoc());
    }

    return list;
  }
}
