class CollectionItem {
  int id;
  String name;
  String url;
  String urlName;
  bool isLoading;
  CollectionItem(
      {required this.id,
      required this.name,
      required this.url,
      required this.urlName,
      this.isLoading = false});

  factory CollectionItem.fromJson(Map<String, dynamic> json) {
    return CollectionItem(
        id: json['id'],
        name: json['name'],
        url: json['url'],
        urlName: json['urlName']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'urlName': urlName,
      };
}
