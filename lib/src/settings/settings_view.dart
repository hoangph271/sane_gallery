import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sane_gallery/src/magic_toolbox/magic_toolbox.dart';

import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/widgets/fancy_elevated_button.dart';
import 'package:sane_gallery/src/widgets/sane_padding.dart';
import 'package:sane_gallery/src/widgets/toggle_theme_buttons.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final aspectRatio = constraints.maxWidth / constraints.maxHeight;
      final isVertical = aspectRatio < 1;

      return SanePadding(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                SanePadding(
                  child: ToggleThemeButtons(
                      settingsController: settingsController),
                ),
                Flex(
                  direction: isVertical ? Axis.vertical : Axis.horizontal,
                  children: [
                    Expanded(
                      flex: isVertical ? 0 : 1,
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(
                            text: settingsController.apiRoot),
                        decoration: const InputDecoration(
                          labelText: 'API Root',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.url,
                      ),
                    ),
                    const SizedBox.square(dimension: 16),
                    Expanded(
                      flex: isVertical ? 0 : 1,
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(
                            text: settingsController.apiKey),
                        decoration: const InputDecoration(
                          labelText: 'API Key',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox.square(dimension: 16),
                    const MagicToolboxButton()
                  ],
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
                // const SanePadding(child: MagicToolboxButton()),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class MagicToolboxButton extends StatelessWidget {
  const MagicToolboxButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: FancyElevatedButton(
        label: const Text('Magic Toolbox'),
        onPressed: () {
          context.go(MagicToolbox.pathName);
        },
        icon: SvgPicture.asset(
          'assets/svg/magic-wand.svg',
          width: 24,
          height: 24,
          colorFilter:
              ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}
