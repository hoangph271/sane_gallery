import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sane_gallery/src/gifs/gif_model.dart';
import 'package:sane_gallery/src/gifs/gifs_controller.dart';
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
    return Column(
      children: [
        SanePadding(
          child: TextField(
            controller: widget.searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: widget.onSearch,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              labelText: 'Keyword',
            ),
          ),
        ),
        if ((widget.pagingController.itemList?.length ?? 0) > 0)
          Center(
              child: Text(
                  'Loaded $_itemsCount/${widget.totalItemsCount} results.')),
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
