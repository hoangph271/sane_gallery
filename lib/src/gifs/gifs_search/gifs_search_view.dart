import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/shared/sane_padding.dart';
import 'package:http/http.dart' as http;

class GifsSearchView extends StatefulWidget {
  final SettingsController settingsController;

  const GifsSearchView({
    super.key,
    required this.settingsController,
  });

  @override
  State<GifsSearchView> createState() => _GifsSearchViewState();
}

class _GifsSearchViewState extends State<GifsSearchView> {
  var gifs = <GifObject>[];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SanePadding(
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: _handleSearch,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                labelText: 'Keyword',
              ),
            ),
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final crossAxisCount = constraints.maxWidth ~/ 300 > 6
                  ? 6
                  : constraints.maxWidth ~/ 300;

              return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: ((context, index) {
                    final gif = gifs[index];

                    return GifCard(
                        gif: gif,
                        settingsController: widget.settingsController);
                  }),
                  itemCount: gifs.length);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleSearch(String keyword) async {
    if (keyword.isEmpty) return;

    final apiRoot = widget.settingsController.apiRoot;
    final apiKey = widget.settingsController.apiKey;

    final url = Uri.parse(
        '$apiRoot/gifs/search?api_key=$apiKey&q=$keyword&limit=15&offset=0&rating=g&lang=en');

    final res = await http.get(url);

    if (res.statusCode != 200) {
      // TODO: Handle error
    }

    final gifs =
        GifObjectList.fromJson(jsonDecode(res.body)['data']).gifObjects;

    setState(() {
      this.gifs = gifs;
    });
  }
}

class GifCard extends StatefulWidget {
  final SettingsController settingsController;

  const GifCard({
    super.key,
    required this.gif,
    required this.settingsController,
  });

  final GifObject gif;

  @override
  State<GifCard> createState() => _GifCardState();
}

class _GifCardState extends State<GifCard> {
  @override
  Widget build(BuildContext context) {
    final isFavorited =
        widget.settingsController.favoriteIds.contains(widget.gif.id);

    return Card(
        child: Column(
      children: [
        Stack(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(widget.gif.images.original.url),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: IconButton(
                icon:
                    Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  if (isFavorited) {
                    widget.settingsController.removeFavorite(widget.gif.id);
                  } else {
                    widget.settingsController.addFavorite(widget.gif.id);
                  }
                },
              ),
            )
          ],
        ),
        SanePadding(child: Text(widget.gif.title)),
      ],
    )
        // leading: Image.network(gif.images.original.url),
        // title: Text(gif.id),
        // subtitle: Text(gif.url),
        );
  }
}

class OriginalImage {
  final String url;

  const OriginalImage({
    required this.url,
  });
}

class GifImage {
  final OriginalImage original;

  const GifImage({
    required this.original,
  });

  GifImage.fromJson(Map<String, dynamic> json)
      : original = OriginalImage(url: json['original']['url']);
}

class GifObject {
  final GifImage images;
  final String id;
  final String url;
  final String title;

  const GifObject({
    required this.id,
    required this.url,
    required this.images,
    required this.title,
  });

  GifObject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'],
        title = json['title'],
        images = GifImage.fromJson(json['images']);
}

class GifObjectList {
  final List<GifObject> gifObjects;

  const GifObjectList({
    required this.gifObjects,
  });

  GifObjectList.fromJson(List<dynamic> json)
      : gifObjects = json.map((e) => GifObject.fromJson(e)).toList();
}
