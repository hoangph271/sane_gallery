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

class GifFetchResult {
  final List<GifObject> gifObjects;
  final Pagination pagination;

  const GifFetchResult({
    required this.gifObjects,
    required this.pagination,
  });

  GifFetchResult.fromJson(Map<String, dynamic> json)
      : gifObjects =
            (json['data'] as List).map((it) => GifObject.fromJson(it)).toList(),
        pagination = Pagination.fromJson(json['pagination']);
}

class Pagination {
  final int count;
  final int offset;
  final int totalCount;

  const Pagination(
      {required this.count, required this.offset, required this.totalCount});

  static fromJson(Map<String, dynamic> json) {
    return Pagination(
      count: json['count'],
      offset: json['offset'],
      totalCount: json['total_count'],
    );
  }

  @override
  String toString() {
    return 'Pagination(count: $count, offset: $offset, totalCount: $totalCount)';
  }
}
