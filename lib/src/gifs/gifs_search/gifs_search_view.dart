import 'package:flutter/material.dart';
import 'package:sane_gallery/src/gifs/gif_model.dart';
import 'package:sane_gallery/src/gifs/gifs_grid/gifs_grid.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/shared/sane_padding.dart';

class GifsSearchView extends StatelessWidget {
  final SettingsController settingsController;
  final ValueChanged<String> handleSearch;
  final TextEditingController searchController;
  final Future<List<GifObject>>? foundGifs;

  const GifsSearchView({
    super.key,
    required this.settingsController,
    required this.handleSearch,
    required this.searchController, 
    required this.foundGifs,
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
          if (foundGifs != null)
            Expanded(
            child: SanePadding(
              paddingSize: PaddingSize.small,
                child: FutureBuilder<List<GifObject>>(
                  future: foundGifs,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasData) {
                      return GifsGrid(
                          gifs: snapshot.data!,
                          settingsController: settingsController);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
