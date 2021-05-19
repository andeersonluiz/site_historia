import 'package:site_historia/Model/project_model.dart';

class   Teacher {
  int id;
  String name;
  String image;
  List<Project> projects;
  String link;
  bool checked;

  Teacher({
    required this.id,
    required this.name,
    required this.image,
    required this.projects,
    required this.link,
    required this.checked,
  });

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

  factory Teacher.fromJsonSimple(Map<String, dynamic> json) {
    return Teacher(
        id: json['id'],
        name: json['name'],
        image: "",
        projects: [],
        link: "",
        checked: false);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'projects': projects.map((project) => project.toJsonSimple()).toList(),
      'link': link,
    };
  }
  Map<String, dynamic> toJsonSimple() => {
    'id': id,
    'name': name,
  };

}
