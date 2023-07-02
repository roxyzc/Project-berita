class Berita {
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String content;
  final String url;
  final String publishedAt;

  Berita(
      {required this.author,
      required this.title,
      required this.description,
      required this.urlToImage,
      required this.content,
      required this.url,
      required this.publishedAt});

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      author: json["author"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      urlToImage: json["urlToImage"] ?? "",
      content: json["content"] ?? "",
      url: json["url"] ?? "",
      publishedAt: json["publishedAt"] ?? ""
    );
  }
}
