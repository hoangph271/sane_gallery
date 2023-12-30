import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sane_gallery/src/gifs/gifs_controller.dart';
import 'package:sane_gallery/src/gifs/gifs_favorites/favorited_gifs_view.dart';
import 'package:sane_gallery/src/gifs/gif_model.dart';
import 'package:sane_gallery/src/gifs/gifs_search/gifs_search_view.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/settings/settings_view.dart';
import 'package:sane_gallery/src/widgets/sane_title.dart';
import 'package:http/http.dart' as http;

class GifsView extends StatefulWidget {
  final SettingsController settingsController;
  final GifsController gifsController;

  const GifsView(
      {super.key,
      required this.settingsController,
      required this.gifsController});

  static const routeName = '/gifs';

  @override
  State<GifsView> createState() => _GifsViewState();
}

const _pageSize = 12;

class _GifsViewState extends State<GifsView> {
  final _searchController = TextEditingController();
  final _pagingController = PagingController<int, GifObject>(
    firstPageKey: 0,
  );

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      if (_searchController.text.isEmpty) {
        _pagingController.appendLastPage([]);
        return;
      }
      _fetchGifs(_searchController.text, pageKey).then((result) {
        final gifs = result.gifObjects;
        final pagination = result.pagination;
        final isLastPage =
            pagination.totalCount == pagination.offset + pagination.count;
        if (isLastPage) {
          _pagingController.appendLastPage(gifs);
        } else {
          final nextPageKey = pageKey + gifs.length;
          _pagingController.appendPage(gifs, nextPageKey);
        }
      });
    });
  }

  Future<GifFetchResult> _fetchGifs(String keyword, int pageKey) async {
    final apiRoot = widget.settingsController.apiRoot;
    final apiKey = widget.settingsController.apiKey;
    final offset = pageKey * _pageSize;
    final url = Uri.parse(
        '$apiRoot/gifs/search?api_key=$apiKey&q=$keyword&limit=$_pageSize&offset=$offset&rating=g&lang=en');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      // TODO: Handle error
    }
    return GifFetchResult.fromJson(jsonDecode(res.body));
  }

  @override
  Widget build(BuildContext context) {
    final favoritesCount = widget.gifsController.favoriteIds.length;

    return SafeArea(
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const SaneTitle(),
            ),
            body: TabBarView(children: [
              GifsSearchView(
                pagingController: _pagingController,
                searchController: _searchController,
                handleSearch: _handleSearch,
                settingsController: widget.settingsController,
                gifsController: widget.gifsController,
              ),
              FavoritedGifsView(
                settingsController: widget.settingsController,
                gifsController: widget.gifsController,
              ),
              SettingsView(settingsController: widget.settingsController),
            ]),
            bottomNavigationBar: TabBar(
              tabs: [
                const Tab(
                  icon: Icon(Icons.image_search),
                  text: 'Search',
                ),
                Tab(
                  icon: const Icon(Icons.favorite_border),
                  text: 'Favourites ($favoritesCount)',
                ),
                const Tab(
                  icon: Icon(Icons.settings_outlined),
                  text: 'Settings',
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
    _pagingController.refresh();
  }
}
