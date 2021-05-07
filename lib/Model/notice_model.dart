class Notice {
  int id;
  String title;
  String subtitle;
  String tag;
  String type;
  String thumb;
  String datePost;
  String content;
  int views;
  bool isTopHeader;
  String author;

  Notice({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.type,
    required this.thumb,
    required this.datePost,
    required this.content,
    required this.views,
    required this.isTopHeader,
    required this.author,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      tag: json['tag'],
      type: json['type'],
      thumb: json['thumb'],
      datePost: json['datePost'],
      content: json['content'],
      views: json['views'],
      isTopHeader: json['isTopHeader'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'tag': tag,
        'type': type,
        'thumb': thumb,
        'author': author,
        'datePost': datePost,
        'content': content,
        'views': views,
        'isTopHeader': isTopHeader
      };
}
