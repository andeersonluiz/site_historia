/// Store responsável pelas informações de recomendações.
///
/// {@category Store}
// ignore: library_names
library RecommendationStore;
import 'package:mobx/mobx.dart';
import 'package:site_historia/Model/recommendationItem_model.dart';
import 'package:site_historia/Model/recommendation_model.dart';
import 'package:site_historia/firebase/recommendation_firestore.dart';

part 'recommendation_store.g.dart';

class RecommendationStore = _RecommendationStoreBase with _$RecommendationStore;

abstract class _RecommendationStoreBase with Store {
  /// Variável que armazena locamelmente as informações de recomendação.
  @observable
  Recommendation? recommendation;

  /// Adiciona uma recomendação para a lista de youtube.
  @action
  addYoutube() {
    recommendation!.youtubeList.add(new RecommendationItem(
        id: recommendation!.youtubeList.length == 0
            ? 0
            : recommendation!.youtubeList.last.id + 1,
        name: "",
        url: ""));
    var newRecommendation = new Recommendation(
        youtubeList: recommendation!.youtubeList,
        blogList: recommendation!.blogList,
        podcastList: recommendation!.podcastList,
        othersList: recommendation!.othersList);
    recommendation = newRecommendation;
  }

  /// Atualiza o nome de uma recomendação de youtube.
  @action
  updateRecommendationYoutubeName(int id, String name) {
    recommendation!.youtubeList[id].name = name;
  }

  /// Atualiza o link de uma recomendação de youtube.
  @action
  updateRecommendationYoutubeUrl(int id, String url) {
    recommendation!.youtubeList[id].url = url;
  }

  /// Exclui uma recomendação de youtube.
  @action
  removeYoutube(RecommendationItem recommendationItem) {
    recommendation!.youtubeList.remove(recommendationItem);
    var newRecommendation = new Recommendation(
        youtubeList: recommendation!.youtubeList,
        blogList: recommendation!.blogList,
        podcastList: recommendation!.podcastList,
        othersList: recommendation!.othersList);
    recommendation = newRecommendation;
  }

  /// Adiciona uma recomendação para a lista de blog.
  @action
  addBlog() {
    recommendation!.blogList.add(new RecommendationItem(
        id: recommendation!.blogList.length == 0
            ? 0
            : recommendation!.blogList.last.id + 1,
        name: "",
        url: ""));
    var newRecommendation = new Recommendation(
        youtubeList: recommendation!.youtubeList,
        blogList: recommendation!.blogList,
        podcastList: recommendation!.podcastList,
        othersList: recommendation!.othersList);
    recommendation = newRecommendation;
  }

  /// Atualiza o nome de uma recomendação de blog.
  @action
  updateRecommendationBlogName(int id, String name) {
    recommendation!.blogList[id].name = name;
  }

  /// Atualiza o link de uma recomendação de blog.
  @action
  updateRecommendationBlogUrl(int id, String url) {
    recommendation!.blogList[id].url = url;
  }

  /// Exclui uma recomendação de blog.
  @action
  removeBlog(RecommendationItem recommendationItem) {
    recommendation!.blogList.remove(recommendationItem);
    var newRecommendation = new Recommendation(
        youtubeList: recommendation!.youtubeList,
        blogList: recommendation!.blogList,
        podcastList: recommendation!.podcastList,
        othersList: recommendation!.othersList);
    recommendation = newRecommendation;
  }

  /// Adiciona uma recomendação para a lista de podcast.
  @action
  addPodcast() {
    recommendation!.podcastList.add(new RecommendationItem(
        id: recommendation!.podcastList.length == 0
            ? 0
            : recommendation!.podcastList.last.id + 1,
        name: "",
        url: ""));
    var newRecommendation = new Recommendation(
        youtubeList: recommendation!.youtubeList,
        blogList: recommendation!.blogList,
        podcastList: recommendation!.podcastList,
        othersList: recommendation!.othersList);
    recommendation = newRecommendation;
  }

  /// Atualiza o nome de uma recomendação de podcast.
  @action
  updateRecommendationPodcastName(int id, String name) {
    recommendation!.podcastList[id].name = name;
  }

  /// Atualiza o link de uma recomendação de podcast.
  @action
  updateRecommendationPodcastUrl(int id, String url) {
    recommendation!.podcastList[id].url = url;
  }

  /// Exclui uma recomendação de podcast.
  @action
  removePodcast(RecommendationItem recommendationItem) {
    recommendation!.podcastList.remove(recommendationItem);
    var newRecommendation = new Recommendation(
        youtubeList: recommendation!.youtubeList,
        blogList: recommendation!.blogList,
        podcastList: recommendation!.podcastList,
        othersList: recommendation!.othersList);
    recommendation = newRecommendation;
  }

  /// Adiciona uma recomendação para a lista de outros.
  @action
  addOther() {
    recommendation!.othersList.add(new RecommendationItem(
        id: recommendation!.othersList.length == 0
            ? 0
            : recommendation!.othersList.last.id + 1,
        name: "",
        url: ""));
    var newRecommendation = new Recommendation(
        youtubeList: recommendation!.youtubeList,
        blogList: recommendation!.blogList,
        podcastList: recommendation!.podcastList,
        othersList: recommendation!.othersList);
    recommendation = newRecommendation;
  }

  /// Atualiza o nome de uma recomendação de outros.
  @action
  updateRecommendationOtherName(int id, String name) {
    recommendation!.othersList[id].name = name;
  }

  /// Atualiza o link de uma recomendação de outros.
  @action
  updateRecommendationOtherUrl(int id, String url) {
    recommendation!.othersList[id].url = url;
  }
  /// Exclui uma recomendação de outros.
  @action
  removeOther(RecommendationItem recommendationItem) {
    recommendation!.othersList.remove(recommendationItem);
    var newRecommendation = new Recommendation(
        youtubeList: recommendation!.youtubeList,
        blogList: recommendation!.blogList,
        podcastList: recommendation!.podcastList,
        othersList: recommendation!.othersList);
    recommendation = newRecommendation;
  }

  /// Atualiza a recomendação no banco de dados.
  @action
  saveRecommendation(Recommendation recommendation) async {
    await RecommendationFirestore.updateRecommendations(recommendation);
  }
}
