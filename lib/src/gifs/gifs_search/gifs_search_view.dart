import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sane_gallery/src/gifs/gif_model.dart';
import 'package:sane_gallery/src/gifs/gifs_controller.dart';
import 'package:sane_gallery/src/gifs/gifs_search/gifs_search_box.dart';
import 'package:sane_gallery/src/widgets/gif_card.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/widgets/sane_padding.dart';

class GifsSearchView extends StatefulWidget {
  final SettingsController settingsController;
  final GifsController gifsController;
  final PagingController<int, GifObject> pagingController;

  final ValueChanged<String> onSearch;
  final TextEditingController searchController;
  final int totalItemsCount;

  const GifsSearchView({
    super.key,
    required this.settingsController,
    required this.pagingController,
    required this.onSearch,
    required this.searchController,
    required this.gifsController, 
    required this.totalItemsCount,
  });

  @override
  State<GifsSearchView> createState() => _GifsSearchViewState();
}

class _GifsSearchViewState extends State<GifsSearchView> {
  int _itemsCount = 0;

  @override
  void initState() {
    widget.pagingController.addListener(() {
      setState(() {
        _itemsCount = widget.pagingController.itemList?.length ?? 0;
      });
    });

    _itemsCount = widget.pagingController.itemList?.length ?? 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GifsSearchView(
      :onSearch,
      :searchController,
    ) = widget;

    return Column(
      children: [
        SanePadding(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: GifsSearchBox(
              searchController: searchController,
              onSearch: onSearch,
            ),
          ),
        ),
        if (_itemsCount > 0)
          Center(
              child: Text(
                  'Loaded $_itemsCount/${widget.totalItemsCount} images.')),
        Expanded(
          child: SanePadding(
            paddingSize: PaddingSize.small,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth ~/ 300 > 6
                    ? 6
                    : constraints.maxWidth ~/ 300;
                return PagedGridView<int, GifObject>(
                  pagingController: widget.pagingController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 4 / 3,
                  ),
                  builderDelegate: PagedChildBuilderDelegate<GifObject>(
                    noItemsFoundIndicatorBuilder: (context) => Center(
                      child: Column(
                        children: [
                          if (searchController.text.isEmpty) ...[
                            const Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: Text('Start by typing a keyword'),
                            ),
                            CachedNetworkImage(
                              imageUrl:
                                  'https://i.giphy.com/RMwYOO5e8pr1lhL8K7.webp',
                              imageBuilder: (context, imageProvider) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(300),
                                  child: Container(
                                    width: 300,
                                    height: 300,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    )),
                                  ),
                                );
                              },
                            ),
                          ] else ...[
                            const Text(
                                'Sorry, no GIFs found. Try another keyword...!'),
                          ],
                        ],
                      ),
                    ),
                    itemBuilder: (context, gif, index) => GifCard(
                      settingsController: widget.settingsController,
                      gif: gif,
                      gifsController: widget.gifsController,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
