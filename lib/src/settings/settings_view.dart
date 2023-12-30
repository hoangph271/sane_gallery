import 'package:flutter/material.dart';
import 'package:sane_gallery/src/gifs/gifs_controller.dart';

import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/shared/sane_padding.dart';

class SettingsView extends StatelessWidget {
  const SettingsView(
      {super.key,
      required this.settingsController,
      required this.gifsController});

  static const routeName = '/settings';

  final SettingsController settingsController;
  final GifsController gifsController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            SanePadding(
                child: Text(
              'Favorite count: ${gifsController.favoriteIds.length}',
            )),
            SanePadding(
              child: DropdownButton<ThemeMode>(
                value: settingsController.themeMode,
                onChanged: settingsController.updateThemeMode,
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('System Theme'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Light Theme'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Dark Theme'),
                  )
                ],
              ),
            ),
            SanePadding(
              child: TextField(
                readOnly: true,
                controller:
                    TextEditingController(text: settingsController.apiRoot),
                decoration: const InputDecoration(
                  labelText: 'API Root',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
              ),
            ),
            SanePadding(
              child: TextField(
                readOnly: true,
                controller:
                    TextEditingController(text: settingsController.apiKey),
                decoration: const InputDecoration(
                  labelText: 'API Key',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            SanePadding(
              child: TextField(
                controller: TextEditingController(
                    text: settingsController.searchLimit.toString()),
                decoration: const InputDecoration(
                  labelText: 'Search Limit',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
