import 'package:site_historia/Model/teacher_model.dart';
import 'package:firebase/firebase.dart';

class TeacherFirestore {
  late List<String> listTeachers = [];

  getTeachers() async {
    var query = firestore().collection("teachers").orderBy('name');
    var result = await query.get();
    final results = result.docs;
    List<Teacher> teachers = [];
    results.forEach((item) {
      teachers.add(Teacher.fromJson(item.data()));
    });
    return teachers;
  }

  Future<String> getTeacherImage(int idTeacher) async {
    var result = await storage().ref().child("teachers").listAll();
    Uri url = await result.items[idTeacher].getDownloadURL();
    return url.toString();
  }
}
