/// Modelo da classe Notícia.
///
/// {@category Model}
// ignore: library_names
library Notice;
class Notice {
  /// Identificador único da Notícia.
  int id;
  /// Título da Notícia.
  String title;
  /// Subtítulo da Notícia.
  String subtitle;
  /// Tag da Notícia (Definidos em `GlobalsVariables`).
  String tag;
  /// Tipo de Notícia (Definidos em `GlobalsVariables`).
  String type;
  /// Áudio da notícia, onde o índice 0 representa o nome da música e o índice 1 representa a url da música.
  List<dynamic> audio;
  /// Imagem que é exibida na prévia da notícia.
  String thumb;
  /// Data de postagem.
  String datePost;
  /// Conteúdo da notícia em html.
  String content;
  /// Visualizações da notícia.
  int views;
  /// Controle para verificar se a notícia está na página principal.
  bool isTopHeader;
  /// Autor da notícia.
  String author;

  /// Construtor da classe `Notice`.
  Notice({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.type,
    required this.audio,
    required this.thumb,
    required this.datePost,
    required this.content,
    required this.views,
    required this.isTopHeader,
    required this.author,
  });

  /// Converter as informações recebidas em `json` do banco de dados para a classe `Notice`.
  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      tag: json['tag'],
      type: json['type'],
      audio: json['audio'],
      thumb: json['thumb'],
      datePost: json['datePost'],
      content: json['content'],
      views: json['views'],
      isTopHeader: json['isTopHeader'],
      author: json['author'],
    );
  }
  /// Converter a classe `Notice` em `json`.
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'tag': tag,
        'type': type,
        'audio': audio,
        'thumb': thumb,
        'author': author,
        'datePost': datePost,
        'content': content,
        'views': views,
        'isTopHeader': isTopHeader
      };
}
