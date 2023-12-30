import 'package:flutter/material.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';

class ToggleThemeButtons extends StatelessWidget {
  const ToggleThemeButtons({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (index) {
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
      },
      isSelected: [
        settingsController.themeMode == ThemeMode.light,
        settingsController.themeMode == ThemeMode.dark,
      ],
      children: const [
        Icon(Icons.light_mode),
        Icon(Icons.dark_mode),
      ],
    );
  }
}
