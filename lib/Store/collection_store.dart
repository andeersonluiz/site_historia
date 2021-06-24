/// Store responsável sobre as informações de acervo.
///
/// {@category Store}
// ignore: library_names
library CollectionStore;
import 'package:file_picker/file_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:site_historia/Model/collection_item.dart';
import 'package:site_historia/Model/collection_model.dart';
import 'package:site_historia/firebase/collection_firestore.dart';

part 'collection_store.g.dart';

class CollectionStore = _CollectionStoreBase with _$CollectionStore;

abstract class _CollectionStoreBase with Store {
  ///Observável que guarda os dados dos acervos localmente.
  @observable
  Collection? collection;

  ///Observável de controle que desabilita o botão enquando um acervo está sendo deletado.
  @observable
  bool isLoading = false;

  /// Adiciona um acervo para a lista de questões de vestibular.
  @action
  addExam() {
    collection!.exams.add(new CollectionItem(
        id: collection!.exams.length == 0 ? 0 : collection!.exams.last.id + 1,
        name: "",
        url: "",
        urlName: ""));

    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  /// Atualiza o nome de um acervo de questão de vestibular.
  @action
  updateRecommendationMovieName(int id, String name) {
    collection!.exams[id].name = name;
  }

  /// Atualiza o link de um acervo de questão de vestibular.
  @action
  updateRecommendationMovieUrl(int id, String url) async {
    collection!.exams[id].url = url;
    collection!.exams[id].urlName = url;
  }

  /// Exclui um acervo de filme.
  @action
  removeExam(CollectionItem collectionItem, int id) {
    collection!.exams.remove(collectionItem);
    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  /// Adiciona um acervo para a lista de artigos.
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
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  /// Atualiza o nome de um acervo de artigo.
  @action
  updateRecommendationArticleName(int id, String name) {
    collection!.articles[id].name = name;
  }

  /// Atualiza o link de um acervo de artigo.
  @action
  updateRecommendationArticleUrl(int id, PlatformFile file) async {
    var url = await CollectionFirestore.insertFile("article", file, id);
    collection!.articles[id].url = url.toString();
    collection!.articles[id].urlName = file.name;
    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
    saveCollection(collection!);
  }

  /// Exclui um acervo de artigo.
  @action
  removeArticle(CollectionItem collectionItem, int id) {
    if (collectionItem.urlName != "") {
      CollectionFirestore.removeFile(
          "article", collectionItem.urlName, collection!.articles[id].id);
    }
    collection!.articles.remove(collectionItem);
    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  /// Adiciona um acervo para a lista de livros.
  @action
  addBook() {
    collection!.books.add(new CollectionItem(
        id: collection!.books.length == 0 ? 0 : collection!.books.last.id + 1,
        name: "",
        url: "",
        urlName: ""));
    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  /// Atualiza o nome de um acervo de livro.
  @action
  updateRecommendationBookName(int id, String name) {
    collection!.books[id].name = name;
  }

  /// Atualiza o link de um acervo de livro.
  @action
  updateRecommendationBookUrl(int id, PlatformFile file) async {
    var url = await CollectionFirestore.insertFile(
        "book", file, collection!.books[id].id);
    collection!.books[id].url = url.toString();
    collection!.books[id].urlName = file.name;

    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
    saveCollection(collection!);
  }

  /// Exclui um acervo de livro.
  @action
  removeBook(CollectionItem collectionItem, int id) {
    if (collectionItem.urlName != "") {
      CollectionFirestore.removeFile(
          "book", collectionItem.urlName, collectionItem.id);
    }
    collection!.books.remove(collectionItem);
    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  /// Adiciona um acervo para a lista de outros.
  @action
  addOther() {
    collection!.others.add(new CollectionItem(
        id: collection!.others.length == 0 ? 0 : collection!.others.last.id + 1,
        name: "",
        url: "",
        urlName: ""));
    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  /// Atualiza o nome de um acervo de outros.
  @action
  updateRecommendationOtherName(int id, String name) {
    collection!.others[id].name = name;
  }

  /// Atualiza o link de um acervo de outros.
  @action
  updateRecommendationOtherUrl(int id, PlatformFile file) async {
    var url = await CollectionFirestore.insertFile(
        "other", file, collection!.exams[id].id);
    collection!.others[id].url = url.toString();
    collection!.others[id].urlName = file.name;

    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
    saveCollection(collection!);
  }

  /// Exclui um acervo de outros.
  @action
  removeOther(CollectionItem collectionItem, int id) {
    if (collectionItem.urlName != "") {
      CollectionFirestore.removeFile(
          "other", collectionItem.urlName, collectionItem.id);
    }
    collection!.others.remove(collectionItem);
    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  /// Atualiza o acervo no banco de dados.
  @action
  saveCollection(Collection collection) async {
    await CollectionFirestore.updateCollection(collection);
  }

  /// Atualiza a variável isLoading.
  @action
  setLoading(bool value) {
    this.isLoading = value;
  }

  /// Atualiza a variavel isLoading de um item da lista de artigos. Serve como controle para
  /// utilizar o placeholder "Carregando..." quando um arquivo é inserido.
  @action
  setLoadingArticle(int index, bool value) {
    collection!.articles[index].isLoading = value;
    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  /// Atualiza a variavel isLoading de um item da lista de livros. Serve como controle para
  /// utilizar o placeholder "Carregando..." quando um arquivo é inserido.
  @action
  setLoadingBook(int index, bool value) {
    collection!.books[index].isLoading = value;
    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }

  /// Atualiza a variavel isLoading de um item da lista de outros. Serve como controle para
  /// utilizar o placeholder "Carregando..." quando um arquivo é inserido.
  @action
  setLoadingOther(int index, bool value) {
    collection!.others[index].isLoading = value;
    var newCollection = new Collection(
        exams: collection!.exams,
        articles: collection!.articles,
        books: collection!.books,
        others: collection!.others);
    collection = newCollection;
  }
}
