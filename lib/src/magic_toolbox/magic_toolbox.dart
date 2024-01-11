import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sane_gallery/src/widgets/fancy_elevated_button.dart';
import 'package:sane_gallery/src/widgets/instax_card.dart';
import 'package:sane_gallery/src/widgets/mobile_only_widget.dart';
import 'package:sane_gallery/src/widgets/sane_padding.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class MagicToolbox extends StatefulWidget {
  static const pathName = '/magic-toolbox';

  const MagicToolbox({super.key});

  @override
  State<MagicToolbox> createState() => _MagicToolboxState();
}

class _MagicToolboxState extends State<MagicToolbox> {
  Future<Uint8List>? _imageBytes;
  final widgetsToImageController = WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: FancyElevatedButton(
                label: const Text(
                  'Instax Printer...!',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final image =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    setState(() {
                      _imageBytes = image.readAsBytes();
                    });
                  }
                },
                icon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.add_a_photo),
                ),
              ),
            ),
            if (_imageBytes != null)
              FutureBuilder(
                  future: _imageBytes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final bytes = snapshot.data as Uint8List;

                      return Column(
                        children: [
                          WidgetsToImage(
                            controller: widgetsToImageController,
                            child: SizedBox(
                              width: 300,
                              height: 300,
                              child:
                                  InstaxCard(imageProvider: MemoryImage(bytes)),
                            ),
                          ),
                          SanePadding(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton.outlined(
                                  onPressed: _saveInstaxPng,
                                  icon: const Icon(Icons.download_sharp),
                                ),
                                const SizedBox(width: 16),
                                MobileOnlyWidget(
                                    child: IconButton.outlined(
                                  icon: const Icon(Icons.share),
                                  onPressed: () async {
                                    final bytes = await widgetsToImageController
                                        .capture();

                                    Share.shareXFiles([
                                      XFile.fromData(
                                        bytes!,
                                        name:
                                            'saneGallery ${DateTime.now().toIso8601String()}.png',
                                        mimeType: 'image/png',
                                      ),
                                    ]);
                                  },
                                )),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
          ],
        )),
      ),
    );
  }

  void _saveInstaxPng() async {
    final bytes = await widgetsToImageController.capture();

    final res = await FileSaver.instance.saveFile(
      name: 'saneGallery ${DateTime.now().toIso8601String()}',
      bytes: bytes!,
      mimeType: MimeType.png,
      ext: 'png',
    );

    print(res);
  }
}
