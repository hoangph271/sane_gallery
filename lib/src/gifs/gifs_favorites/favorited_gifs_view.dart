import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sane_gallery/src/gifs/gif_model.dart';
import 'package:sane_gallery/src/gifs/gifs_grid/gifs_grid.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:http/http.dart' as http;

class FavoritedGifsView extends StatefulWidget {
  final SettingsController settingsController;

  const FavoritedGifsView({
    super.key,
    required this.settingsController,
  });

  @override
  State<FavoritedGifsView> createState() => _FavoritedGifsViewState();
}

class _FavoritedGifsViewState extends State<FavoritedGifsView> {
  late Future<List<GifObject>>? _favoritedGifsFuture;

  get _hasNoFavorites => widget.settingsController.favoriteIds.isEmpty;

  @override
  void initState() {
    super.initState();

    if (!_hasNoFavorites) {
      _favoritedGifsFuture = _getFavoritedGifs();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasNoFavorites) {
      return const Center(
        child: Text('You have no favorited gifs'),
      );
    }

    return FutureBuilder<List<GifObject>>(
      future: _favoritedGifsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final favoritedGifs = snapshot.data!;

          return Expanded(
            child: GifsGrid(
              gifs: favoritedGifs,
              settingsController: widget.settingsController,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<GifObject>> _getFavoritedGifs() async {
    final apiRoot = widget.settingsController.apiRoot;
    final apiKey = widget.settingsController.apiKey;
    final ids = widget.settingsController.favoriteIds;

    final url = Uri.parse('$apiRoot/gifs?api_key=$apiKey&ids=${ids.join(',')}');

    final res = await http.get(url);

    if (res.statusCode != 200) {
      // TODO: Handle error
    }

    final gifs =
        GifObjectList.fromJson(jsonDecode(res.body)['data']).gifObjects;

    return gifs;
  }
}
