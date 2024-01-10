import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sane_gallery/src/widgets/instax_card.dart';

class MagicToolbox extends StatefulWidget {
  static const pathName = '/magic-toolbox';

  const MagicToolbox({super.key});

  @override
  State<MagicToolbox> createState() => _MagicToolboxState();
}

class _MagicToolboxState extends State<MagicToolbox> {
  XFile? image;

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
                      return SizedBox(
                        width: 300,
                        height: 300,
                        child: InstaxCard(
                            imageProvider:
                                MemoryImage(snapshot.data as Uint8List)),
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
}
