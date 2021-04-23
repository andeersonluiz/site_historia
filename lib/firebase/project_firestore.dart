import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:site_historia/model/participant_model.dart';
import 'package:site_historia/model/teacher_model.dart';

import '../model/project_model.dart';

class ProjectFirestore {
  late List<Project> listProjectsOrdenedByName = [];
  String username = "";
  getProjects() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    Query query = instance.collection("projects").orderBy('id');
    QuerySnapshot result = await query.get();
    final results = result.docs;

    List<Project> projects = [];
    results.forEach((item) {
      projects.add(Project.fromJson(item.data()));
    });
    return projects;
  }

  getProjectsName() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    Query query = instance.collection("projects").orderBy('name');
    QuerySnapshot result = await query.get();
    result.docs.forEach((item) {
      listProjectsOrdenedByName.add(Project.fromJson(item.data()));
    });
  }

  getProjectById(String id) {
    return listProjectsOrdenedByName
        .where((element) => element.id.toString() == id)
        .toList()[0];
  }

  Future<String> getHeadProject(String idProject) async {
    ListResult result = await FirebaseStorage.instance
        .ref()
        .child("projects")
        .child("0")
        .child("head")
        .listAll();
    String url = await result.items.first.getDownloadURL();
    return url;
  }

  Future<List<String>> getContentProject(String idProject) async {
    ListResult result = await FirebaseStorage.instance
        .ref()
        .child("projects")
        .child("0")
        .child("content")
        .listAll();
    List<String> urls = [];
    result.items.forEach((item) async {
      urls.add(await item.getDownloadURL());
    });
    return urls;
  }

  Future<List<Map<String, dynamic>>> getTeacherByNameProject(
      String projectName) async {
    var result = await FirebaseFirestore.instance
        .collection("teachers")
        .where('projects', arrayContains: projectName)
        .get();

    List<Map<String, dynamic>> listTeacher = [];
    result.docs.forEach((item) {
      listTeacher.add(item.data());
    });
    return listTeacher;
  }

  Future<String> getUsernameByUid(String uid) async {
    var result =
        await FirebaseFirestore.instance.collection("admins").doc(uid).get();
    username = result.data()!["name"];
    return username;
  }

  Future<bool> addProject(
      String title,
      String imageHeader,
      String? content,
      List<Teacher> listTeacher,
      List<String> listParticipant,
      String author) async {
    try {
      QuerySnapshot result =
          await FirebaseFirestore.instance.collection("projects").get();
      int nextId = result.docs.length;
      List<Participant> listParticipants = [];
      listParticipant.forEach((element) {
        listParticipants.add(Participant(name: element, status: "Aluno"));
      });
      Project project = Project(
          id: nextId,
          author: author,
          content: content.toString(),
          datePost: DateFormat("dd-MM-yyyy hh:mm").format(DateTime.now()),
          imageHeader: imageHeader,
          name: title,
          participants: listParticipants,
          teachers: listTeacher);
      await FirebaseFirestore.instance
          .collection("projects")
          .doc(nextId.toString())
          .set(project.toJson());
    } catch (e) {
      return false;
    }
    return true;
  }
}
