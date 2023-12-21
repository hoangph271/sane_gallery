class GiphyImage {
  final String url;
  final int size;

  const GiphyImage({
    required this.url,
    required this.size,
  });
}

class GifVariants {
  final GiphyImage original;
  final GiphyImage fixedHeight;
  final GiphyImage downsizedStill;

  const GifVariants({
    required this.original,
    required this.fixedHeight,
    required this.downsizedStill,
  });

  GifVariants.fromJson(Map<String, dynamic> json)
      : original = GiphyImage(
            url: json['original']['url'],
            size: int.parse(json['original']['size'])),
        fixedHeight = GiphyImage(
            url: json['fixed_height']['url'],
            size: int.parse(json['fixed_height']['size'])),
        downsizedStill = GiphyImage(
            url: json['downsized_still']['url'],
            size: int.parse(json['downsized_still']['size']));
}

class GifObject {
  final GifVariants giphyVariants;
  final String id;
  final String url;
  final String title;

  const GifObject({
    required this.id,
    required this.url,
    required this.giphyVariants,
    required this.title,
  });

  String get previewUrl =>
      giphyVariants.fixedHeight.size < giphyVariants.original.size
          ? giphyVariants.fixedHeight.url
          : giphyVariants.original.url;

  String get thumbnailUrl => giphyVariants.downsizedStill.url;

  GifObject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'],
        title = json['title'],
        giphyVariants = GifVariants.fromJson(json['images']);
}

class GifObjectList {
  final List<GifObject> gifObjects;

  const GifObjectList({
    required this.gifObjects,
  });

  GifObjectList.fromJson(List<dynamic> json)
      : gifObjects = json.map((e) => GifObject.fromJson(e)).toList();
}
