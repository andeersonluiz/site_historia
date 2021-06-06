/// Modelo da classe Quadro.
///
/// {@category Model}
// ignore: library_names
library Frame;
class Frame {
  /// Identificador único do Quadro.
  int id;
  /// Título do Quadro.
  String title;
  /// Subtítulo do Quadro.
  String subtitle;
  /// Imagem de topo do Quadro.
  String imageHeader;
  /// Legenda da imagem de topo do Quadro.
  String subtitleImage;
  /// Conteúdo do Quadro em html.
  String content;
  /// Video do quadro, onde o índice 0 representa o nome do vídeo e o índice 1 representa a url do vídeo.
  List<dynamic> urlVideo;
  /// Áudio do quadro, onde o índice 0 representa o nome da música e o índice 1 representa a url da música.
  List<dynamic> urlAudio;
  /// Data de postagem.
  String datePost;
  /// Autor da notícia.
  String author;
  /// Visualizações do quadro.
  int views;

  ///Construtor da classe `Frame`.
  Frame(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.imageHeader,
      required this.subtitleImage,
      required this.content,
      required this.urlVideo,
      required this.urlAudio,
      required this.datePost,
      required this.author,
      required this.views});

  /// Converter as informações recebidas em `json` do banco de dados para a classe `Frame`.
  factory Frame.fromJson(Map<String, dynamic> json) {
    return Frame(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      imageHeader: json['imageHeader'],
      subtitleImage: json['subtitleImage'],
      content: json['content'],
      urlVideo: json['urlVideo'],
      urlAudio: json['urlAudio'],
      datePost: json['datePost'],
      author: json['author'],
      views: json['views'],
    );
  }
  /// Converter a classe `Frame` em `json`.
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'imageHeader': imageHeader,
        'subtitleImage': subtitleImage,
        'content': content,
        'urlVideo': urlVideo,
        'urlAudio': urlAudio,
        'datePost': datePost,
        'author': author,
        'views': views,
      };
}
