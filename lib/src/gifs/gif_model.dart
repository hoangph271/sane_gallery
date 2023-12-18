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
