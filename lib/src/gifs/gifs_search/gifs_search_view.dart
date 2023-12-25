import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sane_gallery/src/gifs/gif_model.dart';
import 'package:sane_gallery/src/gifs/gifs_grid/gif_card.dart';
// import 'package:sane_gallery/src/gifs/gifs_grid/gifs_grid.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/shared/sane_padding.dart';

class GifsSearchView extends StatelessWidget {
  final SettingsController settingsController;
  final PagingController<int, GifObject> pagingController;
  final ValueChanged<String> handleSearch;
  final TextEditingController searchController;
  // final Future<List<GifObject>>? foundGifs;

  const GifsSearchView({
    super.key,
    required this.settingsController,
    required this.pagingController,
    required this.handleSearch,
    required this.searchController, 
    // required this.foundGifs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        if (pagingController.itemList?.isNotEmpty ?? false)
          Center(
              child:
                  Text('Found ${pagingController.itemList?.length} results.}')),
          Expanded(
            child: SanePadding(
              paddingSize: PaddingSize.small,
              child: PagedListView<int, GifObject>(
                pagingController: pagingController,
                builderDelegate: PagedChildBuilderDelegate<GifObject>(
                  itemBuilder: (context, gif, index) => GifCard(
                    settingsController: settingsController,
                    gif: gif,
                  ),
                ),
              )
              // child: FutureBuilder<List<GifObject>>(
              //   future: foundGifs,
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }

              //     if (snapshot.hasData) {
              //       final gifs = snapshot.data ?? [];

              //       if (gifs.isEmpty) {
              //         return const Center(child: Text('No results found.'));
              //       }

              //       return GifsGrid(
              //           gifs: gifs,
              //           settingsController: settingsController);
              //     } else if (snapshot.hasError) {
              //       return Text('${snapshot.error}');
              //     }

              //     return const Center(child: CircularProgressIndicator());
              //   },
              // ),
            ),
          ),
      ],
    );
  }
}
