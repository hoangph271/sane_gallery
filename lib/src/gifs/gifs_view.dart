import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sane_gallery/src/gifs/gifs_favorites/favorited_gifs_view.dart';
import 'package:sane_gallery/src/gifs/gif_model.dart';
import 'package:sane_gallery/src/gifs/gifs_search/gifs_search_view.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/widgets/sane_title.dart';
import 'package:http/http.dart' as http;

class GifsView extends StatefulWidget {
  final SettingsController settingsController;

  const GifsView({super.key, required this.settingsController});

  static const routeName = '/gifs';

  @override
  State<GifsView> createState() => _GifsViewState();
}

class _GifsViewState extends State<GifsView> {
  final _searchController = TextEditingController();
  Future<List<GifObject>>? foundGifs;

  Future<List<GifObject>> _fetchGifs(String keyword) async {
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

    return gifs;
  }

  @override
  Widget build(BuildContext context) {
    final favoritesCount = widget.settingsController.favoriteIds.length;

    return SafeArea(
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const SaneTitle(),
            ),
            body: TabBarView(children: [
              GifsSearchView(
                searchController: _searchController,
                handleSearch: _handleSearch,
                settingsController: widget.settingsController,
                foundGifs: foundGifs,
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
          )),
    );
  }

  void _handleSearch(keyword) {
    if (keyword.isEmpty) {
      return;
    }

    setState(() {
      foundGifs = _fetchGifs(keyword);
    });
  }
}
