import 'package:flutter/material.dart';
import 'package:sane_gallery/src/gifs/gifs_search/gifs_search_view.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';

class GifsView extends StatefulWidget {
  final SettingsController settingController;

  const GifsView({super.key, required this.settingController});

  static const routeName = '/gifs';

  @override
  State<GifsView> createState() => _GifsViewState();
}

class _GifsViewState extends State<GifsView> {
  @override
  Widget build(BuildContext context) {
    final favoritesCount = widget.settingController.favoriteIds.length;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('GIFs'),
          ),
          body: TabBarView(children: [
            GifsSearchView(settingsController: widget.settingController),
            Center(
              child: Text('Favourites ($favoritesCount)'),
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
