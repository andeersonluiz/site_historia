import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/project_model.dart';

class ProjectFirestore {
  late List<Project> listProjectsOrdenedByName = [];
  String username="";
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
    /*for (int i = 0; i <= 3; i++) {
      String url = await getHeadProject(i.toString());
      List<String> urls = await getContentProject(i.toString());
      List<Map<String,dynamic>> teachers = await getTeacherByNameProject(i%2==0?"Projeto 1":"Projeto 2");
      instance.collection("projects").doc(i.toString()).set({
        "id": i,
        "name": "Projeto ${i + 1}", 
        "imageHeader": url,
        "imageContent":urls,
        "content":"Lorem ${i+1} ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse interdum sagittis maximus. Morbi metus lacus, consectetur sit amet lorem a, laoreet pharetra est. Aliquam faucibus, orci id ultricies placerat, magna lacus fringilla neque, ut finibus nunc enim a neque. Proin aliquam purus at rutrum dictum. Nullam volutpat mollis metus in placerat. Suspendisse eleifend, ligula in eleifend interdum, enim lacus eleifend ipsum, ac suscipit ligula orci at ex. Pellentesque congue bibendum justo, vel varius urna. Aliquam sit amet velit a nulla blandit luctus.\n\nMorbi accumsan sodales vestibulum. Quisque sed molestie dui. Nam vel nunc ac est molestie congue eget vitae ipsum. Sed tincidunt facilisis magna vitae dapibus. Mauris consectetur erat eget erat posuere congue. Morbi venenatis nibh ac urna blandit, quis tristique tellus pulvinar. Aenean porta, lectus eget consectetur semper, felis felis consectetur sem, a accumsan tellus velit a velit. Nunc ut arcu vel mi imperdiet cursus quis eget lorem. Etiam cursus tempor est ut tristique.",
        "teachers":teachers,
        
        "participants": [
        {
          "name":"Aluno ${i+1}",
          "status":"Aluno",
        },
        {
          "name":"Aluna $i",
          "status":"Aluno",
        },
        
        ],
      });
    }*/
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
    var result = await FirebaseFirestore.instance.collection("admins").doc(uid).get();
    username=result.data()!["name"];
    return username;
  }
}
