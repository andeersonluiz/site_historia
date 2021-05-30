import 'package:site_historia/Model/collection_item.dart';

class Collection {
  List<CollectionItem> movies;
  List<CollectionItem> articles;
  List<CollectionItem> books;
  List<CollectionItem> others;
  Collection(
      {required this.movies,
      required this.articles,
      required this.books,
      required this.others});

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

  Map<String, dynamic> toJson() {
    return {
      'movies': movies.map((e) => e.toJson()).toList(),
      'articles': articles.map((e) => e.toJson()).toList(),
      'books': books.map((e) => e.toJson()).toList(),
      'others': others.map((e) => e.toJson()).toList(),
    };
  }
}
