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
              child: Slider(
                min: 8,
                max: 24,
                divisions: 4,
                label: settingsController.pageSize.toString(),
                onChanged: (value) {
                  settingsController.updatePageSize(value.toInt());
                },
                value: settingsController.pageSize.toDouble(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
