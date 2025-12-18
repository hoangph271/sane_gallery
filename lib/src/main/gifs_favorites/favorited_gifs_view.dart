import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sane_gallery/src/main/gif_model.dart';
import 'package:sane_gallery/src/main/gifs_controller.dart';
import 'package:sane_gallery/src/main/gifs_grid/gifs_grid.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/widgets/sane_padding.dart';

class FavoritedGifsView extends StatefulWidget {
  final SettingsController settingsController;
  final GifsController gifsController;

  const FavoritedGifsView({
    super.key,
    required this.settingsController,
    required this.gifsController,
  });

  @override
  State<FavoritedGifsView> createState() => _FavoritedGifsViewState();
}

class _FavoritedGifsViewState extends State<FavoritedGifsView> {
  late Future<List<GifObject>> _favoritedGifsFuture;

  bool get _hasNoFavorites => widget.gifsController.favoriteIds.isEmpty;
  bool get _hasFavorites => widget.gifsController.favoriteIds.isNotEmpty;

  @override
  void initState() {
    super.initState();

    if (_hasFavorites) {
      _favoritedGifsFuture = _getFavoritedGifs();
    }
  }

  Future<List<GifObject>> _getFavoritedGifs() async {
    final apiRoot = widget.settingsController.apiRoot;
    final apiKey = widget.settingsController.apiKey;
    final ids = widget.gifsController.favoriteIds;

    final url = Uri.parse('$apiRoot/gifs?api_key=$apiKey&ids=${ids.join(',')}');

    final res = await http.get(url);

    if (res.statusCode != 200) {
      final errorText = 'Failed to fetch favorited gifs: ${res.body}';

      return Future.error(errorText);
    }

    final gifs = GifFetchResult.fromJson(jsonDecode(res.body)).gifObjects;

    return gifs;
  }

  @override
  Widget build(BuildContext context) {
    if (_hasNoFavorites) {
      return const Center(
        child: Text("You don't have any favorited gifs yet."),
      );
    }

    return SanePadding(
      child: FutureBuilder<List<GifObject>>(
        future: _favoritedGifsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final favoritedGifs = snapshot.data!;

            return GifsGrid(
              gifs: favoritedGifs,
              settingsController: widget.settingsController,
              gifsController: widget.gifsController,
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
