/// Modelo da classe Projeto.
///
/// {@category Model}
// ignore: library_names
library Project;
import 'package:site_historia/Model/participant_model.dart';
import 'package:site_historia/Model/teacher_model.dart';

class Project {
  /// Identificador único do projeto.
  int id;
  /// Nome do projeto.
  String name;
  /// Imagem de topo do projeto.
  String imageHeader;
  /// Conteúdo do projeto em html.
  String content;
  /// Data da postagem.
  String datePost;
  /// Lista de professores no projeto.
  List<Teacher> teachers;
  /// Lista de participantes no projeto.
  List<Participant> participants;
  /// Autor que publicou o projeto.
  String author;
  /// Variável de controle local para exibir os projetos que estão em um professor. Usado na adição/edição de professores.
  bool checked;

  /// Construtor da classe `Project`.
  Project(
      {required this.id,
      required this.name,
      required this.imageHeader,
      required this.content,
      required this.datePost,
      required this.teachers,
      required this.participants,
      required this.author,
      this.checked=false,
      });

  /// Converter as informações recebidas em `json` do banco de dados para a classe `Project`.
  factory Project.fromJson(Map<String, dynamic> json) {
    List<Participant> listParticipants =
        json['participants'].map<Participant>((item) {
      return Participant.fromJson(item);
    }).toList();

    List<Teacher> listTeacher = json['teachers']
        .map<Teacher>((item) => Teacher.fromJsonSimple(item))
        .toList();

    return Project(
        id: json['id'],
        name: json['name'],
        imageHeader: json['imageHeader'],
        content: json['content'],
        datePost: json['datePost'],
        teachers: listTeacher,
        participants: listParticipants,
        author: json['author']);
  }
  /// Converter as informações recebidas em `json` do banco de dados para a classe `Project`.
  /// Usado para adicionar como um item de `Teacher`.
  factory Project.fromJsonSimple(Map<String, dynamic> json) {
    return Project(
        id: json['id'],
        name: json['name'],
        imageHeader: "",
        content: "",
        datePost: "",
        teachers: [],
        participants: [],
        author:"");
  }

  /// Converter a classe `Project` em `json`.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageHeader': imageHeader,
        'content': content,
        'datePost': datePost,
        'teachers': teachers.map((e) => e.toJsonSimple()).toList(),
        'participants': participants.map((e) => e.toJson()).toList(),
        'author': author,
      };

  /// Converter a classe `Project` em `json`. Usado para adicionar como um item de `Teacher`.
  Map<String, dynamic> toJsonSimple() {
    return {
      'id': id,
    'name': name,
    };
  }
}
