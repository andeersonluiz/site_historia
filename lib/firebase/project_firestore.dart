import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/project_model.dart';

class ProjectFirestore {
  late List<Project> listProjectsOrdenedByName = [];

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
  getProjectById(String id){
    return listProjectsOrdenedByName.where((element) => element.id.toString()==id).toList()[0];
  }
}
