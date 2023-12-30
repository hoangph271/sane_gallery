import 'package:flutter/material.dart';
import 'package:sane_gallery/src/gifs/gifs_service.dart';

class GifsController with ChangeNotifier {
  GifsController(this._gifsService);

  final GifsService _gifsService;

  late List<String> _favoriteIds;

  List<String> get favoriteIds => _favoriteIds;

  Future<void> loadSettings() async {
    _favoriteIds = await _gifsService.favoriteIds();

    notifyListeners();
  }

  Future<void> addFavorite(String id) async {
    if (!_favoriteIds.contains(id)) {
      _favoriteIds.add(id);
      notifyListeners();
    }

    await _gifsService.setFavorites(_favoriteIds);
  }

  Future<void> removeFavorite(String id) async {
    if (_favoriteIds.remove(id)) {
      notifyListeners();
    }

    await _gifsService.setFavorites(_favoriteIds);
  }
}
