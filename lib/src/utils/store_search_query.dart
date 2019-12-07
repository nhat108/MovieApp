import 'package:shared_preferences/shared_preferences.dart';

class StoreSearchQuery {
  final SharedPreferences prefs;
  static const String LIST_QUERY_KEY = 'ListQueryKey';
  StoreSearchQuery(this.prefs);

  Future<void> storeQuery(String query) async {
    var list = prefs.getStringList(LIST_QUERY_KEY);
    if (list == null) {
      list = List();
    }
    if (!list.contains(query)) {
      list.add(query);
    }
    return prefs.setStringList(LIST_QUERY_KEY, list);
  }

  List<String> getQueryList()  {
    return prefs.getStringList(LIST_QUERY_KEY);
  }
  void deleteQuery(String query){
     var list = prefs.getStringList(LIST_QUERY_KEY);
     list.remove(query);
  }
  Future<void> deleteAllQuery()async{
    return prefs.setStringList(LIST_QUERY_KEY, List());
  }
}
