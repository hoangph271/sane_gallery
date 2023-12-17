import 'package:flutter/material.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/shared/sane_padding.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
    required SettingsController controller,
  });

  static const routeName = '/SampleItemListView';

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Center(
        child: SearchAnchor(
          builder: (context, controller) {
            return SanePadding(
              child: SearchBar(
                hintText: 'Search',
                leading: const Icon(Icons.search),
                controller: controller,
                onTap: () => controller.openView(),
                onChanged: (value) => controller.openView(),
              ),
            );
          },
          suggestionsBuilder: (context, controller) {
            return List.generate(items.length, (index) {
              return ListTile(
                title: Text(items[index].id.toString()),
                onTap: () {
                  // Navigate to the details page. If the user leaves and
                  // returns to the app after it has been killed while running
                  // in the background, the navigation stack is restored.
                  Navigator.restorablePushNamed(
                    context,
                    SampleItemDetailsView.routeName,
                    arguments: items[index].id,
                  );
                },
              );
            });
          },
        ),
      ),
    );
  }
}
