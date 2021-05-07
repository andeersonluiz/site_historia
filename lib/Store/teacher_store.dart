import 'package:mobx/mobx.dart';
import 'package:site_historia/firebase/teacher_firestore.dart';

part 'teacher_store.g.dart';

class TeacherStore = _TeacherStoreBase with _$TeacherStore;

abstract class _TeacherStoreBase with Store {
  @observable
  ObservableFuture? listTeachers;

  @action
  getTeachers() async {
    final teacherFirestore = TeacherFirestore();

    listTeachers = ObservableFuture(teacherFirestore.getTeachers());
  }
}
