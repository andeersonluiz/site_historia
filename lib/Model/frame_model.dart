class Frame {
  int id;
  String title;
  String subtitle;
  String imageHeader;
  String content;
  List<dynamic> urlVideo;
  List<dynamic> urlAudio;
  String datePost;
  String author;
  int views;
  Frame(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.imageHeader,
      required this.content,
      required this.urlVideo,
      required this.urlAudio,
      required this.datePost,
      required this.author,
      required this.views});

  factory Frame.fromJson(Map<String, dynamic> json) {
    return Frame(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      imageHeader: json['imageHeader'],
      content: json['content'],
      urlVideo: json['urlVideo'],
      urlAudio: json['urlAudio'],
      datePost: json['datePost'],
      author: json['author'],
      views: json['views'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'imageHeader': imageHeader,
        'content': content,
        'urlVideo': urlVideo,
        'urlAudio': urlAudio,
        'datePost': datePost,
        'author': author,
        'views': views,
      };
}
