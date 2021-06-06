/// Modelo da classe Professor.
///
/// {@category Model}
// ignore: library_names
library Teacher;
import 'package:site_historia/Model/project_model.dart';

class Teacher {
  /// Identificador único do professor.
  int id;
  /// Nome do professor.
  String name;
  /// Url da imagem do professor.
  String image;
  /// Lista de projetos que o professor participa.
  List<Project> projects;
  /// Url de acesso a informações mais completas do professor.
  String link;
  /// Variável de controle local para exibir os professores que estão em um projeto. Usado na adição/edição de projetos.
  bool checked;

  /// Construtor da classe `Teacher`.
  Teacher({
    required this.id,
    required this.name,
    required this.image,
    required this.projects,
    required this.link,
    required this.checked,
  });

  /// Converter as informações recebidas em `json` do banco de dados para a classe `Teacher`.
  factory Teacher.fromJson(Map<String, dynamic> json) {
    List<Project> listProjects = json['projects'].map<Project>((project)=>Project.fromJsonSimple(project)).toList();

    return Teacher(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        projects: listProjects,
        link: json['link'],
        checked: false);
  }

  /// Converter as informações recebidas em `json` do banco de dados para a classe `Teacher`.
  /// Usado para adicionar como um item de `Project`.
  factory Teacher.fromJsonSimple(Map<String, dynamic> json) {
    return Teacher(
        id: json['id'],
        name: json['name'],
        image: "",
        projects: [],
        link: "",
        checked: false);
  }

  /// Converter a classe `Teacher` em `json`.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'projects': projects.map((project) => project.toJsonSimple()).toList(),
      'link': link,
    };
  }

  /// Converter a classe `Teacher` em `json`. Usado para adicionar como um item de `Project`.
  Map<String, dynamic> toJsonSimple() => {
    'id': id,
    'name': name,
  };

}
