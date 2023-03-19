class DataUtils {
  static String equalFilter(Map<String, dynamic>? equalFilter,
      {bool includeWhere = false}) {
    String equalString = "";

    if (equalFilter != null) {
      if (includeWhere) {
        equalString = "WHERE";
      }
      for (MapEntry<String, dynamic> entry in equalFilter.entries) {
        equalString += " ${entry.key} = '${entry.value}' AND";
      }
      if (equalString.isNotEmpty) {
        equalString = equalString.substring(0, equalString.length - 3);
      }
    }
    return equalString;
  }

  static String containsFilterToQuery(Map<String, dynamic>? filterContains,
      {bool includeWhere = false}) {
    String containsString = "";

    if (filterContains != null) {
      if (includeWhere) {
        containsString = "WHERE";
      }
      for (MapEntry<String, dynamic> entry in filterContains.entries) {
        String like = "LIKE '%${entry.value}%'";

        containsString += " ${entry.key} $like OR";
      }
      if (containsString.isNotEmpty) {
        containsString = containsString.substring(0, containsString.length - 3);
      }
    }
    return containsString;
  }
}
