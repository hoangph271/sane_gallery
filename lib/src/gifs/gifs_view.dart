import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sane_gallery/src/gifs/gifs_search/gif_model.dart';
import 'package:sane_gallery/src/gifs/gifs_search/gifs_grid.dart';
import 'package:sane_gallery/src/gifs/gifs_search/gifs_search_view.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:http/http.dart' as http;

class GifsView extends StatefulWidget {
  final SettingsController settingsController;

  const GifsView({super.key, required this.settingsController});

  static const routeName = '/gifs';

  @override
  State<GifsView> createState() => _GifsViewState();
}

class _GifsViewState extends State<GifsView> {
  var searchedGifs = <GifObject>[];
  final _searchController = TextEditingController();

  Future<void> _handleSearch(String keyword) async {
    if (keyword.isEmpty) return;

    final apiRoot = widget.settingsController.apiRoot;
    final apiKey = widget.settingsController.apiKey;

    final url = Uri.parse(
        '$apiRoot/gifs/search?api_key=$apiKey&q=$keyword&limit=15&offset=0&rating=g&lang=en');

    final res = await http.get(url);

    if (res.statusCode != 200) {
      // TODO: Handle error
    }

    final gifs =
        GifObjectList.fromJson(jsonDecode(res.body)['data']).gifObjects;

    setState(() {
      searchedGifs = gifs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesCount = widget.settingsController.favoriteIds.length;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('GIFs'),
          ),
          body: TabBarView(children: [
            GifsSearchView(
              searchController: _searchController,
              handleSearch: _handleSearch,
              settingsController: widget.settingsController,
              gifs: searchedGifs,
            ),
            FavoritedGifsView(
              settingsController: widget.settingsController,
            ),
          ]),
          bottomNavigationBar: TabBar(
            tabs: [
              const Tab(
                icon: Icon(Icons.search),
                text: 'Search',
              ),
              Tab(
                icon: const Icon(Icons.favorite_border),
                text: 'Favourites ($favoritesCount)',
              ),
            ],
          ),
        ));
  }
}

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
  late Future<List<GifObject>> _favoritedGifsFuture;

  @override
  void initState() {
    super.initState();

    _favoritedGifsFuture = _getFavoritedGifs();
  }

  @override
  Widget build(BuildContext context) {
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
