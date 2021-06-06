/// Modelo da classe Acervo.
///
/// {@category Model}
// ignore: library_names
library Collection;
import 'package:site_historia/Model/collection_item.dart';

class Collection {
  /// Lista de `CollectionItem` com informações de filme.
  List<CollectionItem> movies;
  /// Lista de `CollectionItem` com informações de artigos.
  List<CollectionItem> articles;
  /// Lista de `CollectionItem` com informações de livros.
  List<CollectionItem> books;
  /// Lista de `CollectionItem` com informações de outros.
  List<CollectionItem> others;

  /// Construtor da classe `Collection`.
  Collection(
      {required this.movies,
      required this.articles,
      required this.books,
      required this.others});

  /// Converter as informações recebidas em `json` do banco de dados para a classe `Collection`.
  factory Collection.fromJson(Map<String, dynamic> json) {
    var movies = json['movies'].isEmpty
        ? [CollectionItem(id: 0, name: "", url: "", urlName: "")]
        : json['movies']
            .map<CollectionItem>((item) => CollectionItem.fromJson(item))
            .toList();
    var articles = json['articles'].isEmpty
        ? [CollectionItem(id: 0, name: "", url: "", urlName: "")]
        : json['articles']
            .map<CollectionItem>((item) => CollectionItem.fromJson(item))
            .toList();
    var books = json['books'].isEmpty
        ? [CollectionItem(id: 0, name: "", url: "", urlName: "")]
        : json['books']
            .map<CollectionItem>((item) => CollectionItem.fromJson(item))
            .toList();
    var others = json['others'].isEmpty
        ? [CollectionItem(id: 0, name: "", url: "", urlName: "")]
        : json['others']
            .map<CollectionItem>((item) => CollectionItem.fromJson(item))
            .toList();
    return Collection(
        movies: movies, articles: articles, books: books, others: others);
  }
  /// Converter a classe `Collection` em `json`.
  Map<String, dynamic> toJson() {
    return {
      'movies': movies.map((e) => e.toJson()).toList(),
      'articles': articles.map((e) => e.toJson()).toList(),
      'books': books.map((e) => e.toJson()).toList(),
      'others': others.map((e) => e.toJson()).toList(),
    };
  }
}
