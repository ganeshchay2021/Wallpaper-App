// ignore_for_file: public_member_api_docs, sort_constructors_first

class PhotoModel {
  final String url;
  final SrcModel src;
  PhotoModel({
    required this.url,
    required this.src,
  });

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      url: map['url'] ?? " ",
      src: SrcModel.fromMap(map["src"] ?? " "),
    );
  }
}

class SrcModel {
  final String portrait;
  final String original;
  final String large;
  final String medium;
  final String landscape;
  SrcModel({
    required this.portrait,
    required this.large,
    required this.medium,
    required this.original,
    required this.landscape,
  });

  factory SrcModel.fromMap(Map<String, dynamic> map) {
    return SrcModel(
        portrait: map["portrait"] ?? "",
        large: map["large"] ?? "",
        medium: map["medium"] ?? "",
        original: map["original"] ?? "",
        landscape: map["landscape"] ?? " ");
  }
}
