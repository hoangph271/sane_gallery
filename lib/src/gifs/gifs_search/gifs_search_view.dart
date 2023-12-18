import 'package:flutter/material.dart';
import 'package:sane_gallery/src/gifs/gifs_search/gif_model.dart';
import 'package:sane_gallery/src/gifs/gifs_search/gifs_grid.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/shared/sane_padding.dart';

class GifsSearchView extends StatelessWidget {
  final SettingsController settingsController;
  final List<GifObject> gifs;
  final ValueChanged<String> handleSearch;
  final TextEditingController searchController;

  const GifsSearchView({
    super.key,
    required this.settingsController,
    required this.gifs,
    required this.handleSearch,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SanePadding(
            child: TextField(
              controller: searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: handleSearch,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                labelText: 'Keyword',
              ),
            ),
          ),
          Expanded(
            child: SanePadding(
              paddingSize: PaddingSize.small,
              child:
                  GifsGrid(gifs: gifs, settingsController: settingsController),
            ),
          ),
        ],
      ),
    );
  }
}
