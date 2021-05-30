import 'package:firebase/firebase.dart';
import 'package:site_historia/Model/recommendation_model.dart';

class RecommendationFirestore {
  static getRecommendations() async {
    var query = firestore().collection("recommendations");

    var results = await query.get();
    final result = results.docs[0];
    Recommendation recommendations = Recommendation.fromJson(result.data());
    return recommendations;
  }

  static updateRecommendations(Recommendation recommendation) async {
    await firestore()
        .collection("recommendations")
        .doc("0")
        .update(data: recommendation.toJson());
  }
}
