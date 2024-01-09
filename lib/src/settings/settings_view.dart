import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/widgets/sane_padding.dart';
import 'package:sane_gallery/src/widgets/toggle_theme_buttons.dart';

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
              child: ToggleThemeButtons(settingsController: settingsController),
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
            SanePadding(
                child: UnconstrainedBox(
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  // settingsController.reset();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    children: [
                      const Text('Magic Toolbox'),
                      SvgPicture.asset('assets/svg/magic-wand.svg',
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(
                              Theme.of(context).primaryColor, BlendMode.srcIn)),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
