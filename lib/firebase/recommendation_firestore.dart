/// Classe responsável realizar as operações do objeto `Recommendation` no banco de dados.
///
/// {@category Firebase}
// ignore: library_names
library RecommendationFirestore;
import 'package:firebase/firebase.dart';
import 'package:site_historia/Model/recommendation_model.dart';

class RecommendationFirestore {
  /// Retorna às recomendações do banco de dados.
  static getRecommendations() async {
    var query = firestore().collection("recommendations");

    var results = await query.get();
    final result = results.docs[0];
    Recommendation recommendations = Recommendation.fromJson(result.data());
    return recommendations;
  }

  /// Atualiza às recomendações no banco de dados.
  static updateRecommendations(Recommendation recommendation) async {
    await firestore()
        .collection("recommendations")
        .doc("0")
        .update(data: recommendation.toJson());
  }
}
