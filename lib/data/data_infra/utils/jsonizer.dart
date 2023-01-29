abstract class Table {
  Table();
  String get id;
  Map<String, dynamic> toJson();
  Table fromJson(Map<String, dynamic> json);
  List<Table> fromJsonList(List<Map<String, dynamic>> jsonList);
}
