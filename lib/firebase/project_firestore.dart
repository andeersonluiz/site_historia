import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/project_model.dart';

class ProjectFirestore {
  late List<String> listProjects = [];

  getProjects() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    Query query = instance.collection("projects").orderBy('id');
    QuerySnapshot result = await query.get();
    final results = result.docs;
    List<Project> notices = [];
    results.forEach((item) {
      notices.add(Project.fromJson(item.data()));
    });
    return notices;
  }

  getProjectsName() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    Query query = instance.collection("projects").orderBy('name');
    QuerySnapshot result = await query.get();
    result.docs.forEach((item) {
      listProjects.add(item['name']);
    });
  }
}
