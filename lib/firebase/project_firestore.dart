import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:site_historia/Model/participant_model.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:firebase/firebase.dart';

class ProjectFirestore {
  late List<Project> listProjectsOrderedByName = [];
  String username = "";

  static getProjects() async {
    var query = firestore().collection("projects").orderBy('id');
    var result = await query.get();
    final results = result.docs;

    List<Project> projects = [];
    results.forEach((item) {
      projects.add(Project.fromJson(item.data()));
    });

    return projects;
  }

  static getProjectSortedByTitle() async {
    var query = firestore().collection("projects").orderBy('name');
    var result = await query.get();
    List<Project> projectByName = [];
    result.docs.forEach((item) {
      projectByName.add(Project.fromJson(item.data()));
    });
    return projectByName;
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

  static Future<String> getUsernameByUid(String uid) async {
    var result = await firestore().collection("admins").doc(uid).get();
    return result.data()["name"];
  }

  static Future<bool> addProject(
      String title,
      PickedFile? imageHeader,
      String? content,
      List<Teacher> listTeacher,
      List<String> listParticipant,
      String author) async {
    try {
      var result = await firestore().collection("projects").get();
      int nextId = result.docs.length + 1;
      List<Participant> listParticipants = [];
      listParticipant.forEach((element) {
        listParticipants.add(Participant(name: element, status: "Aluno"));
      });
      var metadata = await imageHeader!.readAsBytes();
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

  static Future<bool> updateProject(
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
      Uri url = Uri.parse(imageHeader!.path.toString());

      if (!imageHeader.path.contains("firebasestorage")) {
        var metadata = await imageHeader.readAsBytes();
        UploadTaskSnapshot task = await storage()
            .ref()
            .child("projects/$id.png")
            .put(metadata, UploadMetadata(contentType: 'image/jpg'))
            .future;
        url = await task.ref.getDownloadURL();
      }

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

  static deleteProject(int id) async {
    await firestore().collection("projects").doc(id.toString()).delete();
    await storage().ref().child("projects/$id.png").delete();
    return;
  }
}
