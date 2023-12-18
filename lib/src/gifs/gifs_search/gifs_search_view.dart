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
  // TODO: Lift state up to GifsView
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
          Expanded(
            child: SanePadding(
              paddingSize: PaddingSize.small,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final crossAxisCount = constraints.maxWidth ~/ 300 > 6
                      ? 6
                      : constraints.maxWidth ~/ 300;
              
                  return Expanded(
                    child: GridView.builder(
                      itemCount: gifs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 4 / 3,
                      ),
                      itemBuilder: ((context, index) {
                        final gif = gifs[index];

                        return GifCard(
                            gif: gif,
                            settingsController: widget.settingsController);
                      }),
                    ),
                  );
                },
              ),
            ),
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
        child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.gif.images.original.url),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.grey.withOpacity(0.4),
                  Colors.black.withOpacity(0.4),
                ],
              ),
            ),
            child: SanePadding(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    widget.gif.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
                  IconButton.filledTonal(
                    icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border),
                    onPressed: () {
                      if (isFavorited) {
                        widget.settingsController.removeFavorite(widget.gif.id);
                      } else {
                        widget.settingsController.addFavorite(widget.gif.id);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
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
