import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class ShareImageButton extends StatelessWidget {
  const ShareImageButton({
    super.key,
    required this.widgetsToImageController,
  });

  final WidgetsToImageController widgetsToImageController;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      icon: const Icon(Icons.share),
      onPressed: () async {
        final bytes = await widgetsToImageController.capture();

        Share.shareXFiles([
          XFile.fromData(
            bytes!,
            name: 'saneGallery ${DateTime.now().toIso8601String()}.png',
            mimeType: 'image/png',
          ),
        ]);
      },
    );
  }
}
