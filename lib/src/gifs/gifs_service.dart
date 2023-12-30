import 'package:sane_gallery/src/shared/shared_preferences.dart';

const String favoritesSharedPreferencesKey = '@favorites';

class GifsService {
  Future<List<String>> favoriteIds() async {
    final prefs = await getSharedPreferences();

    List<String> ids = prefs.getStringList(favoritesSharedPreferencesKey) ?? [];

    return ids;
  }

  Future<void> setFavorites(List<String> ids) async {
    (await getSharedPreferences())
        .setStringList(favoritesSharedPreferencesKey, ids);
  }
}
