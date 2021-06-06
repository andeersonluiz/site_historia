/// Modelo da classe Item de Recomendação. Utilizado dentro da classe `Recomendadtion`.
///
/// {@category Model}
// ignore: library_names
library RecommendationItem;

class RecommendationItem {
  /// Identificador único do item de recomendação.
  int id;
  /// Nome do item de recomendação.
  String name;
  /// Url do item de recomendação.
  String url;

  ///Construtor classe `RecommendationItem`.
  RecommendationItem({required this.id, required this.name, required this.url});

  /// Converter as informações recebidas em `json` do banco de dados para a classe `RecommendationItem`.
  factory RecommendationItem.fromJson(Map<String, dynamic> json) {
    return RecommendationItem(
        id: json['id'], name: json['name'], url: json['url']);
  }
  /// Converter a classe `Teacher` em `json`.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }
}
