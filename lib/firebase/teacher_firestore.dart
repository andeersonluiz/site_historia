import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:site_historia/model/teacher_model.dart';

class TeacherFirestore {
  late List<String> listTeachers = [];

  getTeachers() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    Query query = instance.collection("teachers").orderBy('name');
    QuerySnapshot result = await query.get();
    final results = result.docs;
    List<Teacher> teachers = [];
    /* for (int i = 0; i < 5; i++) {
      String urlTemp = await getTeacherImage(i);
      DocumentSnapshot result =
          await instance.collection("projects").doc("projeto1").get();
      DocumentSnapshot result2 =    
          await instance.collection("projects").doc("projeto2").get();
      instance.collection("teachers").doc(i.toString()).set({
        "id": i,
        "name": "Professor ${i + 1}",
        "links": ["www.abc$i.com.br", "www.def$i.com.br"],
        "projects": [
          result['name'],
          result2['name'],
        ],
        "image": urlTemp,
      });
    }*/
    results.forEach((item) {
      teachers.add(Teacher.fromJson(item.data()));
    });
    return teachers;
  }

  Future<String> getTeacherImage(int idTeacher) async {
    var result =
        await FirebaseStorage.instance.ref().child("teachers").listAll();
    String url = await result.items[idTeacher].getDownloadURL();
    return url;
  }
}
