import 'package:shared_preferences/shared_preferences.dart';

class GifsService {
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<List<String>> favoriteIds() async {
    final prefs = await getSharedPreferences();

    List<String> ids = prefs.getStringList('@favorites') ?? [];

    return ids;
  }

  Future<void> setFavorites(List<String> ids) async {
    (await getSharedPreferences()).setStringList('@favorites', ids);
  }
}
