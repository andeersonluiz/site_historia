import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:site_historia/firebase/project_firestore.dart';

part 'project_store.g.dart';

class ProjectStore = _ProjectStoreBase with _$ProjectStore;

abstract class _ProjectStoreBase with Store {
  @observable
  ObservableFuture? listProjects;

  @observable
  ObservableList listProjectsOrdered = ObservableList.of([]);

  @action
  getProjects() async {
    listProjects = ObservableFuture(ProjectFirestore.getProjects());
  }

  @action
  getProjectById(String id) {
    var result = listProjects!.value
        .where((element) => element.id.toString() == id)
        .toList();
    return result[0];
  }

  @action
  addProject(
      String title,
      PickedFile? imageHeader,
      String? content,
      List<Teacher> listTeacher,
      List<String> listParticipant,
      String author) async {
    bool result = await ProjectFirestore.addProject(
        title, imageHeader, content, listTeacher, listParticipant, author);
    if (result) {
      await getProjects();
      return true;
    } else {
      return false;
    }
  }

  @action
  updateProject(
      int id,
      String title,
      PickedFile? imageHeader,
      String? content,
      List<Teacher> listTeacher,
      List<String> listParticipant,
      String author) async {
    bool result = await ProjectFirestore.updateProject(
        id, title, imageHeader, content, listTeacher, listParticipant, author);
    if (result) {
      await getProjects();
      return true;
    } else {
      return false;
    }
  }

  deleteProject(int id) {
    ProjectFirestore.deleteProject(id);
  }

  getUsernameByUid(String uid) async {
    if (GlobalsVariables.username == "") {
      String name = await ProjectFirestore.getUsernameByUid(uid);
      GlobalsVariables.username = name;
    }
    return GlobalsVariables.username;
  }

  getProjectSortedByTitle() async {
    var result = await ProjectFirestore.getProjectSortedByTitle();
    listProjectsOrdered = ObservableList.of(result);
  }
}
