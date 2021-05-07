import 'package:site_historia/Model/participant_model.dart';
import 'package:site_historia/Model/teacher_model.dart';

class Project {
  int id;
  String name;
  String imageHeader;
  String content;
  String datePost;
  List<Teacher> teachers;
  List<Participant> participants;
  String author;
  Project(
      {required this.id,
      required this.name,
      required this.imageHeader,
      required this.content,
      required this.datePost,
      required this.teachers,
      required this.participants,
      required this.author});

  factory Project.fromJson(Map<String, dynamic> json) {
    List<Participant> listParticipants =
        json['participants'].map<Participant>((item) {
      return Participant.fromJson(item);
    }).toList();

    List<Teacher> listTeacher = json['teachers']
        .map<Teacher>((item) => Teacher.fromJson(item))
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
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageHeader': imageHeader,
        'content': content,
        'datePost': datePost,
        'teachers': teachers.map((e) => e.toJson()).toList(),
        'participants': participants.map((e) => e.toJson()).toList(),
        'author': author,
      };
}
