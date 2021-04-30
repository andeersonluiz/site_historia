import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:site_historia/model/participant_model.dart';
import 'package:site_historia/model/teacher_model.dart';
import 'package:firebase/firebase.dart';
import '../model/project_model.dart';

class ProjectFirestore {
  late List<Project> listProjectsOrdenedByName = [];
  String username = "";
  getProjects() async {
    var query = firestore().collection("projects").orderBy('id');
    var result = await query.get();
    final results = result.docs;

    List<Project> projects = [];
    results.forEach((item) {
      projects.add(Project.fromJson(item.data()));
    });
    return projects;
  }

  getProjectsName() async {
    var query = firestore().collection("projects").orderBy('name');
    var result = await query.get();
    result.docs.forEach((item) {
      listProjectsOrdenedByName.add(Project.fromJson(item.data()));
    });
  }

  getProjectById(String? id) {
    final result= listProjectsOrdenedByName
        .where((element) => element.id.toString() == id)
        .toList();
        print(result.length);
        if(result.isNotEmpty){
          return result[0];
        }else{
          return null;
        }
        
  }

  Future<String> getHeadProject(String idProject) async {
    ListResult result = await storage()
        .ref()
        .child("projects")
        .child("0")
        .child("head")
        .listAll();
    Uri url = await result.items.first.getDownloadURL();
    return url.toString();
  }

  Future<List<Map<String, dynamic>>> getTeacherByNameProject(
      String projectName) async {
    var result = await firestore()
        .collection("teachers")
        .where('projects', "array-contains", projectName)
        .get();

    List<Map<String, dynamic>> listTeacher = [];
    result.docs.forEach((item) {
      listTeacher.add(item.data());
    });
    return listTeacher;
  }

  Future<String> getUsernameByUid(String uid) async {
    var result = await firestore().collection("admins").doc(uid).get();
    username = result.data()["name"];
    return username;
  }

  Future<bool> addProject(
      String title,
      PickedFile? imageHeader,
      String? content,
      List<Teacher> listTeacher,
      List<String> listParticipant,
      String author) async {
    try {
      var result = await firestore().collection("projects").get();
      int nextId = result.docs.length;
      List<Participant> listParticipants = [];
      listParticipant.forEach((element) {
        listParticipants.add(Participant(name: element, status: "Aluno"));
      });
      var metadata = await imageHeader?.readAsBytes();
      UploadTaskSnapshot task = await storage()
          .ref()
          .child("projects/$nextId.png")
          .put(metadata, UploadMetadata(contentType: 'image/jpg'))
          .future;

      Uri url = await task.ref.getDownloadURL();
      Project project = Project(
          id: nextId,
          author: author,
          content: content.toString(),
          datePost: DateFormat("dd-MM-yyyy hh:mm").format(DateTime.now()),
          imageHeader: url.toString(),
          name: title,
          participants: listParticipants,
          teachers: listTeacher);
      await firestore()
          .collection("projects")
          .doc(nextId.toString())
          .set(project.toJson());
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> updateProject(
      int id,
      String title,
      PickedFile? imageHeader,
      String? content,
      List<Teacher> listTeacher,
      List<String> listParticipant,
      String author) async {
    try {
      List<Participant> listParticipants = [];
      listParticipant.forEach((element) {
        listParticipants.add(Participant(name: element, status: "Aluno"));
      });
      var metadata = await imageHeader?.readAsBytes();
      UploadTaskSnapshot task = await storage()
          .ref()
          .child("projects/$id.png")
          .put(metadata, UploadMetadata(contentType: 'image/jpg'))
          .future;

      Uri url = await task.ref.getDownloadURL();
      Project project = Project(
          id: id,
          author: author,
          content: content.toString(),
          datePost: DateFormat("dd-MM-yyyy hh:mm").format(DateTime.now()),
          imageHeader: url.toString(),
          name: title,
          participants: listParticipants,
          teachers: listTeacher);
      await firestore()
          .collection("projects")
          .doc(id.toString())
          .update(data: project.toJson());
    } catch (e) {
      return false;
    }
    return true;
  }
}
