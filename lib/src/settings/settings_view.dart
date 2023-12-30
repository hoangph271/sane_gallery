import 'package:flutter/material.dart';

import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/widgets/sane_padding.dart';

class SettingsView extends StatelessWidget {
  const SettingsView(
      {super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            SanePadding(
              child: ToggleButtons(
                onPressed: _handleToggleTheme,
                isSelected: [
                  settingsController.themeMode == ThemeMode.light,
                  settingsController.themeMode == ThemeMode.dark,
                ],
                children: const [
                  Icon(Icons.light_mode),
                  Icon(Icons.dark_mode),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Page size: ${settingsController.pageSize}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Slider(
                    min: 8,
                    max: 24,
                    divisions: 4,
                    label: settingsController.pageSize.toString(),
                    onChanged: (value) {
                      settingsController.updatePageSize(value.toInt());
                    },
                    value: settingsController.pageSize.toDouble(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleToggleTheme(index) {
    if (index == 0) {
      settingsController.updateThemeMode(
        settingsController.themeMode == ThemeMode.light
            ? ThemeMode.system
            : ThemeMode.light,
      );
    } else if (index == 1) {
      settingsController.updateThemeMode(
        settingsController.themeMode == ThemeMode.dark
            ? ThemeMode.system
            : ThemeMode.dark,
      );
    }
  }
}
