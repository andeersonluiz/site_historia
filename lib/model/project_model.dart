import 'package:intl/intl.dart';
import 'package:site_historia/model/participant_model.dart';
import 'package:site_historia/model/teacher_model.dart';

class Project {
  int id;
  String name;
  String imageHeader;
  String content;
  String datePost;
  List<dynamic> imageContent;
  List<Teacher> teachers;
  List<Participant> participant;
  String author;
  Project({required this.id, required this.name, required this.imageHeader,required this.content,required this.datePost, required this.imageContent, required this.teachers, required this.participant,required this.author});

  factory Project.fromJson(Map<String, dynamic> json) {
    List<Participant> listParticipants = json['participants'].map<Participant>((item)=>Participant.fromJsoN(item)).toList();
    List<Teacher> listTeacher = json['teachers'].map<Teacher>((item)=>Teacher.fromJson(item)).toList();
    final f =DateFormat("dd-MM-yyyy hh:mm");

    return Project(
        id: json['id'],
        name: json['name'],
        imageHeader: json['imageHeader'],
        content:json['content'],
        datePost: f.format(DateTime.parse(json['datePost'].toDate().toString())),
        imageContent:json['imageContent'],
        teachers: listTeacher,
        participant:listParticipants,
        author: json['author']

      );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageHeader': imageHeader,
        'content':content,
        'datePost':datePost,
        'imageContent':imageContent,
        'participant':participant,
        'author':author,
      };
}
