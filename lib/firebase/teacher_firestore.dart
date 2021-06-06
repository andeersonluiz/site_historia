/// Classe responsável realizar as operações do objeto `Teacher` no banco de dados.
///
/// {@category Firebase}
// ignore: library_names
library TeacherFirestore;
import 'package:image_picker/image_picker.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:firebase/firebase.dart';

class TeacherFirestore {
  /// Retorna todos os professores do banco de dados.
  static getTeachers() async {
    var query = firestore().collection("teachers").orderBy('name');
    var result = await query.get();
    final results = result.docs;
    List<Teacher> teachers = [];
    results.forEach((item) {
      teachers.add(Teacher.fromJson(item.data()));
    });
    return teachers;
  }
  /// Adiciona um professor ao banco de dados.
  static addTeacher(
      String name,
      PickedFile image,
      List<Project> projects,
      String link,
      ) async {
    try{
      var result = await firestore().collection("teachers").get();
      int nextId = result.docs.length+1;
      var bytesImage = await image.readAsBytes();
      var task = await storage().ref().child("teachers/$nextId.png").put(bytesImage,UploadMetadata(contentType: "image/png")).future;
      var imageUrl = await task.ref.getDownloadURL();

      await firestore().collection("projects").get().then((listProjects) =>
          listProjects.docs.forEach((project) =>
              projects.forEach((element) async{
                if(project.data()['id']==element.id){
                  var query = await firestore().collection("projects").doc(project.data()['id'].toString()).get();
                  Project proj = Project.fromJson(query.data());
                  proj.teachers.add(Teacher.fromJsonSimple({
                    'id':nextId,'name':name,}
                  ));
                  await firestore().collection("projects").doc(project.data()['id'].toString()).update(data: proj.toJson());
                }
              })
          )
      );
      Teacher teacher = Teacher(
        id: nextId,
        name: name,
        image: imageUrl.toString(),
        checked: false,
        link: link,
        projects: projects,
      );
      await firestore().collection("teachers").doc(nextId.toString()).set(teacher.toJson());
      return true;
    }catch(e){
      return false;
    }
  }

  /// Atualiza as informações de um professor no banco de dados.
  static updateTeacher(
      Teacher teacher,
      String name,
      PickedFile image,
      List<Project> projects,
      String link,
      ) async {
    try{
      Uri urlImage = Uri.parse(image.path);
      if(!image.path.contains("firebasestorage")){
        var bytesImage = await image.readAsBytes();
        var task = await storage().ref().child("teachers/${teacher.id}.png").put(bytesImage,UploadMetadata(contentType: "image/jpg")).future;
        urlImage = await task.ref.getDownloadURL();
      }
      await firestore().collection("projects").get().then((listProjects) =>
          listProjects.docs.forEach((project) async {
            Project pj = Project.fromJson(project.data());
            if (!pj.teachers.any((element) => teacher.id == element.id) &&
                projects.any((element) => pj.id == element.id)) {
              var query = await firestore().collection("projects").doc(
                  pj.id.toString()).get();
              Project proj = Project.fromJson(query.data());
              proj.teachers.add(Teacher.fromJsonSimple({
                'id': teacher.id, 'name': name,}
              ));
              await firestore().collection("projects")
                  .doc(pj.id.toString())
                  .update(data: proj.toJson());
            } else
            if (pj.teachers.any((element) => teacher.id == element.id) &&
                !projects.any((element) => pj.id == element.id)){

              var query = await firestore().collection("projects").doc(
                  pj.id.toString()).get();
              Project proj = Project.fromJson(query.data());
              proj.teachers.removeWhere((element) =>
              element.id == teacher.id);
              await firestore().collection("projects").doc(
                  pj.id.toString()).update(data: proj.toJson());
            }
           }
          )
      );
      Teacher teacherUpdated = Teacher(
        id: teacher.id,
        name:  name,
        image: urlImage.toString(),
        checked:  teacher.checked,
        link: link,
        projects: projects,

      );
      await firestore().collection("teachers").doc(teacherUpdated.id.toString()).update(data:teacherUpdated.toJson());
      return true;
    }catch(e){
      return false;
    }
  }

  /// Exclui um professor do banco de dados.
  static deleteTeacher(int id) async {
    await firestore().collection("projects").get().then((listProjs){
      listProjs.docs.forEach((project) {
        project.data()['teachers'].forEach((item) async {
          if(item['id']==id){
            var query = await firestore().collection("projects").doc(project.data()['id'].toString()).get();
            Project proj = Project.fromJson(query.data());
            proj.teachers.removeWhere((element) => element.id==id);
            await firestore().collection("projects").doc(project.data()['id'].toString()).update(data: proj.toJson());
          }
        });}
      );});
    await firestore().collection("teachers").doc(id.toString()).delete();
    await storage().ref().child("teachers/$id.png").delete();

  }
}