/// Modelo da classe Item de Acervo. Utilizado dentro da classe `Collection`.
///
/// {@category Model}
// ignore: library_names
library CollectionItem;

class CollectionItem {
  /// Identificador único do item de acervo.
  int id;
  /// Nome do item de acervo.
  String name;
  /// Url do item de acervo.
  String url;
  /// Nome do arquivo url do item de acervo.
  String urlName;
  /// Variável local que controla se o usuário está carregando um novo arquivo.
  bool isLoading;

  ///Construtor da classe `CollectionItem`.
  CollectionItem(
      {required this.id,
      required this.name,
      required this.url,
      required this.urlName,
      this.isLoading = false});

  /// Converter as informações recebidas em `json` do banco de dados para a classe `CollectionItem`.
  factory CollectionItem.fromJson(Map<String, dynamic> json) {
    return CollectionItem(
        id: json['id'],
        name: json['name'],
        url: json['url'],
        urlName: json['urlName']);
  }
  /// Converter a classe `CollectionItem` em `json`.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'urlName': urlName,
      };
}
