import 'package:mobx/mobx.dart';
import 'package:site_historia/Model/recommendationItem_model.dart';
import 'package:site_historia/Model/recommendation_model.dart';
import 'package:site_historia/firebase/recommendation_firestore.dart';

part 'recommendation_store.g.dart';

class RecommendationStore = _RecommendationStoreBase with _$RecommendationStore;

abstract class _RecommendationStoreBase with Store {
  @observable
  Recommendation? recommendation;

  @action
  addYoutube() {
    recommendation!.youtubeList.add(new RecommendationItem(
        id: recommendation!.youtubeList.last.id + 1, name: "", url: ""));
    var newRecommendation = new Recommendation(
        youtubeList: recommendation!.youtubeList,
        blogList: recommendation!.blogList,
        podcastList: recommendation!.podcastList,
        othersList: recommendation!.othersList);
    recommendation = newRecommendation;
  }

  @action
  updateRecommendationYoutubeName(int id, String name) {
    recommendation!.youtubeList[id].name = name;
  }

  @action
  updateRecommendationYoutubeUrl(int id, String url) {
    recommendation!.youtubeList[id].url = url;
  }

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

  @action
  addBlog() {
    recommendation!.blogList.add(new RecommendationItem(
        id: recommendation!.blogList.last.id + 1, name: "", url: ""));
    var newRecommendation = new Recommendation(
        youtubeList: recommendation!.youtubeList,
        blogList: recommendation!.blogList,
        podcastList: recommendation!.podcastList,
        othersList: recommendation!.othersList);
    recommendation = newRecommendation;
  }

  @action
  updateRecommendationBlogName(int id, String name) {
    recommendation!.blogList[id].name = name;
  }

  @action
  updateRecommendationBlogUrl(int id, String url) {
    recommendation!.blogList[id].url = url;
  }

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

  @action
  addPodcast() {
    recommendation!.podcastList.add(new RecommendationItem(
        id: recommendation!.podcastList.last.id + 1, name: "", url: ""));
    var newRecommendation = new Recommendation(
        youtubeList: recommendation!.youtubeList,
        blogList: recommendation!.blogList,
        podcastList: recommendation!.podcastList,
        othersList: recommendation!.othersList);
    recommendation = newRecommendation;
  }

  @action
  updateRecommendationPodcastName(int id, String name) {
    recommendation!.podcastList[id].name = name;
  }

  @action
  updateRecommendationPodcastUrl(int id, String url) {
    recommendation!.podcastList[id].url = url;
  }

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

  @action
  addOther() {
    recommendation!.othersList.add(new RecommendationItem(
        id: recommendation!.othersList.last.id + 1, name: "", url: ""));
    var newRecommendation = new Recommendation(
        youtubeList: recommendation!.youtubeList,
        blogList: recommendation!.blogList,
        podcastList: recommendation!.podcastList,
        othersList: recommendation!.othersList);
    recommendation = newRecommendation;
  }

  @action
  updateRecommendationOtherName(int id, String name) {
    recommendation!.othersList[id].name = name;
  }

  @action
  updateRecommendationOtherUrl(int id, String url) {
    recommendation!.othersList[id].url = url;
  }

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

  @action
  saveRecommendation(Recommendation recommendation) async {
    await RecommendationFirestore.updateRecommendations(recommendation);
  }
}
