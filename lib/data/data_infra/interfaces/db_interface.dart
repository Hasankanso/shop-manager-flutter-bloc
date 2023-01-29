import 'package:shop_manager/data/data_infra/utils/jsonizer.dart';

abstract class DBInterface {
  Future<void> connect(String host, int port, String username, String password,
      String databaseName);
  Future<void> close();

  Future<List<Map<String, dynamic>>> query(String query);
  Future<List<T>> select<T>(
      String table, String query, Table builder, Map<String, dynamic>? args);

  Future<void> insert(String table, Table data);
  Future<void> update(String table, Table data);
  Future<void> delete(String table, String id);
}
