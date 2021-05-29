import 'package:site_historia/Model/recommendationItem_model.dart';

class Recommendation {
  List<RecommendationItem> youtubeList;
  List<RecommendationItem> blogList;
  List<RecommendationItem> podcastList;
  List<RecommendationItem> othersList;

  Recommendation(
      {required this.youtubeList,
      required this.blogList,
      required this.podcastList,
      required this.othersList});

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    var youtubeList = json['youtube'].isEmpty
        ? [RecommendationItem(id: 0, name: "", url: "")]
        : json['youtube']
            .map<RecommendationItem>(
                (item) => RecommendationItem.fromJson(item))
            .toList();
    var blogList = json['blog'].isEmpty
        ? [RecommendationItem(id: 0, name: "", url: "")]
        : json['blog']
            .map<RecommendationItem>(
                (item) => RecommendationItem.fromJson(item))
            .toList();
    var podcastList = json['podcast'].isEmpty
        ? [RecommendationItem(id: 0, name: "", url: "")]
        : json['podcast']
            .map<RecommendationItem>(
                (item) => RecommendationItem.fromJson(item))
            .toList();
    var othersList = json['other'].isEmpty
        ? [RecommendationItem(id: 0, name: "", url: "")]
        : json['other']
            .map<RecommendationItem>(
                (item) => RecommendationItem.fromJson(item))
            .toList();
    return Recommendation(
        blogList: blogList,
        podcastList: podcastList,
        youtubeList: youtubeList,
        othersList: othersList);
  }

  Map<String, dynamic> toJson() {
    return {
      'youtube': youtubeList.map((e) => e.toJson()).toList(),
      'blog': blogList.map((e) => e.toJson()).toList(),
      'podcast': podcastList.map((e) => e.toJson()).toList(),
      'other': othersList.map((e) => e.toJson()).toList(),
    };
  }
}
