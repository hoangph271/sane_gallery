import 'package:flutter/material.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({super.key, required this.settingController});

  final SettingsController settingController;

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context)!.settings.arguments as int?;

    if (itemId == null) {
      return const Scaffold(
        body: Center(
          child: Text('No item specified!'),
        ),
      );
    }

    final isFavorited =
        settingController.favoriteIds.contains(itemId.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('More Information Here'),
            ElevatedButton(
              onPressed: () {
                if (isFavorited) {
                  settingController.removeFavorite(itemId.toString());
                } else {
                  settingController.addFavorite(itemId.toString());
                }
              },
              child: Text(isFavorited ? 'Unfavorite' : 'Favorite'),
            ),
          ],
        ),
      ),
    );
  }
}
