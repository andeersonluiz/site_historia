import 'package:file_picker/file_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:site_historia/Model/collection_item.dart';
import 'package:site_historia/Model/collection_model.dart';
import 'package:site_historia/firebase/collection_firestore.dart';

part 'collection_store.g.dart';

class CollectionStore = _CollectionStoreBase with _$CollectionStore;

abstract class _CollectionStoreBase with Store {
  @observable
  Collection? collection;

  @observable
  bool isLoading = false;

  @action
  addMovie() {
    collection!.movies.add(new CollectionItem(
        id: collection!.movies.length == 0 ? 0 : collection!.movies.last.id + 1,
        name: "",
        url: "",
        urlName: ""));

    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  @action
  updateRecommendationMovieName(int id, String name) {
    collection!.movies[id].name = name;
  }

  @action
  updateRecommendationMovieUrl(int id, String url) async {
    collection!.movies[id].url = url;
    collection!.movies[id].urlName = url;
  }

  @action
  removeMovie(CollectionItem collectionItem, int id) {
    collection!.movies.remove(collectionItem);
    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  @action
  addArticle() {
    collection!.articles.add(new CollectionItem(
        id: collection!.articles.length == 0
            ? 0
            : collection!.articles.last.id + 1,
        name: "",
        url: "",
        urlName: ""));
    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  @action
  updateRecommendationArticleName(int id, String name) {
    collection!.articles[id].name = name;
  }

  @action
  updateRecommendationArticleUrl(int id, PlatformFile file) async {
    var url = await CollectionFirestore.insertFile("article", file, id);
    collection!.articles[id].url = url.toString();
    collection!.articles[id].urlName = file.name!;
    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
    saveCollection(collection!);
  }

  @action
  removeArticle(CollectionItem collectionItem, int id) {
    if (collectionItem.urlName != "") {
      CollectionFirestore.removeFile(
          "article", collectionItem.urlName, collection!.articles[id].id);
    }
    collection!.articles.remove(collectionItem);
    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  @action
  addBook() {
    collection!.books.add(new CollectionItem(
        id: collection!.books.length == 0 ? 0 : collection!.books.last.id + 1,
        name: "",
        url: "",
        urlName: ""));
    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  @action
  updateRecommendationBookName(int id, String name) {
    collection!.books[id].name = name;
  }

  @action
  updateRecommendationBookUrl(int id, PlatformFile file) async {
    var url = await CollectionFirestore.insertFile(
        "book", file, collection!.books[id].id);
    collection!.books[id].url = url.toString();
    collection!.books[id].urlName = file.name!;

    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
    saveCollection(collection!);
  }

  @action
  removeBook(CollectionItem collectionItem, int id) {
    if (collectionItem.urlName != "") {
      CollectionFirestore.removeFile(
          "book", collectionItem.urlName, collectionItem.id);
    }
    collection!.books.remove(collectionItem);
    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  @action
  addOther() {
    collection!.others.add(new CollectionItem(
        id: collection!.others.length == 0 ? 0 : collection!.others.last.id + 1,
        name: "",
        url: "",
        urlName: ""));
    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  @action
  updateRecommendationOtherName(int id, String name) {
    collection!.others[id].name = name;
  }

  @action
  updateRecommendationOtherUrl(int id, PlatformFile file) async {
    var url = await CollectionFirestore.insertFile(
        "other", file, collection!.movies[id].id);
    collection!.others[id].url = url.toString();
    collection!.others[id].urlName = file.name!;

    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
    saveCollection(collection!);
  }

  @action
  removeOther(CollectionItem collectionItem, int id) {
    if (collectionItem.urlName != "") {
      CollectionFirestore.removeFile(
          "other", collectionItem.urlName, collectionItem.id);
    }
    collection!.others.remove(collectionItem);
    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  @action
  saveCollection(Collection collection) async {
    await CollectionFirestore.updateCollection(collection);
  }

  @action
  setLoading(bool value) {
    this.isLoading = value;
  }

  @action
  setLoadingArticle(int index, bool value) {
    collection!.articles[index].isLoading = value;
    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  @action
  setLoadingBook(int index, bool value) {
    collection!.books[index].isLoading = value;
    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  @action
  setLoadingOther(int index, bool value) {
    collection!.others[index].isLoading = value;
    var newCollection = new Collection(
        movies: collection!.movies,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }
}
