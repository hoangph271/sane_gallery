import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class ShareImageButton extends StatefulWidget {
  const ShareImageButton({
    super.key,
    required this.widgetsToImageController,
  });

  final WidgetsToImageController widgetsToImageController;

  @override
  State<ShareImageButton> createState() => _ShareImageButtonState();
}

class _ShareImageButtonState extends State<ShareImageButton> {
  var _isSharing = false;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      icon: const Icon(Icons.share),
      onPressed: _isSharing
          ? null
          : () async {
              try {
                setState(() {
                  _isSharing = true;
                });

                final bytes = await widget.widgetsToImageController.capture();

                await Share.shareXFiles([
                  XFile.fromData(
                    bytes!,
                    name: 'saneGallery ${DateTime.now().toIso8601String()}.png',
                    mimeType: 'image/png',
                  ),
                ]);
              } finally {
                setState(() {
                  _isSharing = false;
                });
              }
      },
    );
  }
}
