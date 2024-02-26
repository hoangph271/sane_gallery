import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:sane_gallery/src/main/gifs_controller.dart';
import 'package:sane_gallery/src/main/gifs_favorites/favorited_gifs_view.dart';
import 'package:sane_gallery/src/main/gif_model.dart';
import 'package:sane_gallery/src/main/gifs_search/gifs_search_view.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/settings/settings_view.dart';
import 'package:sane_gallery/src/widgets/sane_title.dart';
import 'package:http/http.dart' as http;

import 'gallery_view.dart';

class MainView extends StatefulWidget {
  static const pathName = '/';

  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _searchController = TextEditingController();
  final _pagingController = PagingController<int, GifObject>(
    firstPageKey: 0,
  );
  var _totalItemsCount = 0;

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((offset) {
      if (_searchController.text.isEmpty) {
        _pagingController.appendLastPage([]);
        return;
      }

      _fetchGifs(_searchController.text, offset).then((result) {
        final gifs = result.gifObjects;
        final pagination = result.pagination;
        final isLastPage =
            pagination.totalCount == pagination.offset + pagination.count;

        setState(() {
          _totalItemsCount = pagination.totalCount;
        });

        if (isLastPage) {
          _pagingController.appendLastPage(gifs);
        } else {
          final nextOffset = offset + gifs.length;
          _pagingController.appendPage(gifs, nextOffset);
        }
      });
    });
  }

  Future<GifFetchResult> _fetchGifs(String keyword, int offset) async {
    final SettingsController(:apiRoot, :apiKey, :pageSize) =
        Provider.of<SettingsController>(context, listen: false);

    final url = Uri.parse(
        '$apiRoot/gifs/search?api_key=$apiKey&q=$keyword&limit=$pageSize&offset=$offset&rating=g&lang=en');

    final res = await http.get(url);

    if (res.statusCode != 200) {
      // TODO: Handle error
    }
    return GifFetchResult.fromJson(jsonDecode(res.body));
  }

  void _handleSearch(keyword) {
    if (keyword.isEmpty) {
      return;
    }
    _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final gifsController = Provider.of<GifsController>(context);
    final settingsController = Provider.of<SettingsController>(context);

    final favoritesCount = gifsController.favoriteIds.length;

    return SafeArea(
      child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: const SaneTitle(),
            ),
            body: ListenableBuilder(
              listenable: gifsController,
              builder: (context, child) {
                return TabBarView(children: [
                  const GalleryView(),
                  GifsSearchView(
                    pagingController: _pagingController,
                    searchController: _searchController,
                    onSearch: _handleSearch,
                    settingsController: settingsController,
                    gifsController: gifsController,
                    totalItemsCount: _totalItemsCount,
                  ),
                  FavoritedGifsView(
                    settingsController: settingsController,
                    gifsController: gifsController,
                  ),
                  SettingsView(settingsController: settingsController),
                ]);
              },
            ),
            bottomNavigationBar: TabBar(
              tabs: [
                const Tab(
                  icon: Icon(Icons.photo_library_outlined),
                  text: 'Gallery',
                ),
                const Tab(
                  icon: Icon(Icons.image_search),
                  text: 'Search',
                ),
                Tab(
                  icon: const Icon(Icons.favorite_border),
                  text: 'Saved ($favoritesCount)',
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
}
