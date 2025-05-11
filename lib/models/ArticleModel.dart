class ArticleModel {
  final String title;
  final String? imgUrl;
  final String? author;
  final String sharedAt;
  final String description;
  final String content;
  final String url;

  ArticleModel( {
    required this.url,
    required this.content,
    required this.description,
    required this.title,
    required this.imgUrl,
    required this.author,
    required this.sharedAt,
  });
}


