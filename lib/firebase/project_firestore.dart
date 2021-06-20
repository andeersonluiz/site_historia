/// Classe responsável realizar as operações do objeto `Project` no banco de dados.
///
/// {@category Firebase}
// ignore: library_names
library ProjectFirestore;
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:site_historia/Model/participant_model.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:firebase/firebase.dart';

class ProjectFirestore {

  /// Retorna todos os projetos do banco de dados.
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

  /// Retorna todos os projetos do banco de dados, ordenados por título.
  static getProjectSortedByTitle() async {
    var query = firestore().collection("projects").orderBy('name');
    var result = await query.get();
    List<Project> projectByName = [];
    result.docs.forEach((item) {
      projectByName.add(Project.fromJson(item.data()));
    });
    return projectByName;
  }

  /// Retorna os professores que estão inseridos no projeto.
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

  /// Retorna o nome do usuário que está logado.
  static Future<String> getUsernameByUid(String uid) async {
    var result = await firestore().collection("admins").doc(uid).get();
    return result.data()["name"];
  }

  /// Adiciona um projeto ao banco de dados.
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

      await firestore()
          .collection("teachers")
          .get()
          .then((listTeachers) => listTeachers.docs.forEach((teacher) async {
        Teacher teach = Teacher.fromJson(teacher.data());
        if (listTeacher.any((element) => teach.id == element.id)) {
          var query = await firestore()
              .collection("teachers")
              .doc(teach.id.toString())
              .get();
          Teacher teacherTemp = Teacher.fromJson(query.data());

          teacherTemp.projects.add(Project.fromJsonSimple({
            'id': nextId,
            'name': title,
          }));
          await firestore()
              .collection("teachers")
              .doc(teacher.id.toString())
              .update(data: teacherTemp.toJson());
        }
      }));

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

  /// Atualiza um projeto no banco de dados.
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

      await firestore()
          .collection("teachers")
          .get()
          .then((listTeachers) => listTeachers.docs.forEach((teacher) async {
            Teacher teach = Teacher.fromJson(teacher.data());
            // Verifica se o professor já possui o projeto e verifica se
            // na lista de professores selecionados existe o professores escolhidos no checkbox
        if (!teach.projects.any((element) => id == element.id) &&
            listTeacher.any((element) => teach.id == element.id)) {
          var query = await firestore()
              .collection("teachers")
              .doc(teach.id.toString())
              .get();
          Teacher teacherTemp = Teacher.fromJson(query.data());

          teacherTemp.projects.add(Project.fromJsonSimple({
            'id': id,
            'name': title,
          }));
          await firestore()
              .collection("teachers")
              .doc(teacher.id.toString())
              .update(data: teacherTemp.toJson());

        } else if (teach.projects.any((element) => id == element.id) &&
            !listTeacher.any((element) => teach.id == element.id)) {
          var query = await firestore()
              .collection("teachers")
              .doc(teach.id.toString())
              .get();
          Teacher teacherRes = Teacher.fromJson(query.data());
          teacherRes.projects
              .removeWhere((element) => element.id == id);
          await firestore()
              .collection("teachers")
              .doc(teacherRes.id.toString())
              .update(data: teacherRes.toJson());
        }
      }));
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

  /// Exclui um projeto do banco de dados.
  static deleteProject(int id) async {
    await firestore().collection("projects").doc(id.toString()).delete();
    await storage().ref().child("projects/$id.png").delete();
    var result = await storage().ref().child("projects/$id(content)").listAll();
    for (int i = 0; i < result.items.length; i++) {
      await storage()
          .ref()
          .child("projects/$id(content)/${result.items[i].name}")
          .delete();
    }
    await firestore()
        .collection("teachers")
        .get()
        .then((listTeachers) => listTeachers.docs.forEach((teacher) async {
      Teacher teach = Teacher.fromJson(teacher.data());
      if (teach.projects.any((element) => id == element.id)) {
        var query = await firestore()
            .collection("teachers")
            .doc(teach.id.toString())
            .get();
        Teacher teacherRes = Teacher.fromJson(query.data());
        teacherRes.projects
            .removeWhere((element) => element.id == id);
        await firestore()
            .collection("teachers")
            .doc(teacherRes.id.toString())
            .update(data: teacherRes.toJson());
      }
    }));
    return;
  }

  /// Insere uma imagem no banco de dados, na seção de projetos , e retorna a url da mesma.
  static convertBase64ToUrl(
      String fileName, Uint8List base64, String id) async {
    UploadTaskSnapshot task = await storage()
        .ref()
        .child("projects/$id(content)/$fileName")
        .put(base64, UploadMetadata(contentType: 'image/jpg'))
        .future;
    var url = await task.ref.getDownloadURL();
    return url.toString();
  }

  /// Remove uma imagem da seção de projetos no banco de dados.
  static removeFilename(String fileName, String id) async {
    await storage().ref("projects/$id(content)/$fileName").delete();
  }

  /// Recebe o próximo id que será utilizado na inserção de um projeto.
  static getNextId() async {
    var result = await firestore().collection("projects").get();
    return result.docs.length + 1;
  }

  /// Validador para excluir a(s) imagem(s) caso o usuário não crie o projeto.
  ///
  /// A cada inserção de imagem do usuário durante a criação/edição de texto, as imagens são salvas dentro do banco de dados.
  /// A função é executada se o usuário inserir imagens mas não criar o projeto.
  static clearContent(String id, {DateTime? time}) async {
    var result = await storage().ref().child("projects/$id(content)").listAll();
    if (time != null) {
      for (int i = 0; i < result.items.length; i++) {
        FullMetadata metadata = await result.items[i].getMetadata();
        if (metadata.timeCreated.isAfter(time)) {
          storage()
              .ref()
              .child("projects/$id(content)/${result.items[i].name}")
              .delete();
        }
      }
    } else {
      for (int i = 0; i < result.items.length; i++) {
        storage()
            .ref()
            .child("projects/$id(content)/${result.items[i].name}")
            .delete();
      }
    }
  }
}



