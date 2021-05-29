class RecommendationItem {
  int id;
  String name;
  String url;

  RecommendationItem({required this.id, required this.name, required this.url});

  factory RecommendationItem.fromJson(Map<String, dynamic> json) {
    return RecommendationItem(
        id: json['id'], name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }
}
