import 'dart:io';
import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sane_gallery/src/widgets/instax_card.dart';
import 'package:sane_gallery/src/widgets/sane_padding.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class MagicToolbox extends StatefulWidget {
  static const pathName = '/magic-toolbox';

  const MagicToolbox({super.key});

  @override
  State<MagicToolbox> createState() => _MagicToolboxState();
}

class _MagicToolboxState extends State<MagicToolbox> {
  XFile? image;
  final widgetsToImageController = WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Magic Toolbox'),
            IconButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  setState(() {
                    this.image = image;
                  });
                }
              },
              icon: const Icon(Icons.photo_filter_outlined),
            ),
            if (image != null)
              FutureBuilder(
                  future: image?.readAsBytes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          WidgetsToImage(
                            controller: widgetsToImageController,
                            child: SizedBox(
                              width: 300,
                              height: 300,
                              child: InstaxCard(
                                  imageProvider:
                                      MemoryImage(snapshot.data as Uint8List)),
                            ),
                          ),
                          SanePadding(
                            child: IconButton.outlined(
                              onPressed: _saveInstaxPng,
                              icon: const Icon(Icons.download_sharp),
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
      name: image!.name,
      bytes: bytes!,
      mimeType: MimeType.png,
      ext: 'png',
    );

    print(res);
  }
}
