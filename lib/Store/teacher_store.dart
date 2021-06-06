/// Store responsável pelas informações do professor.
///
/// {@category Store}
// ignore: library_names
library TeacherStore;
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:site_historia/firebase/teacher_firestore.dart';

part 'teacher_store.g.dart';

class TeacherStore = _TeacherStoreBase with _$TeacherStore;

abstract class _TeacherStoreBase with Store {
  /// Observável que salva a lista de professores localmente.
  @observable
  ObservableFuture? listTeachers;

  /// Recupera a lista de professores do banco de dados.
  @action
  getTeachers() async {
    listTeachers = ObservableFuture(TeacherFirestore.getTeachers());
  }

  /// Adiciona professor e valida se a operação do banco de dados foi feita corretamente.
  @action
  addTeacher(
      String name,
      PickedFile image,
      List<Project> projects,
      String link,
      ) async {

    var result = await TeacherFirestore.addTeacher(name, image, projects, link);
    if(result){
      await getTeachers();
      return true;
    }else{
      return false;
    }
  }
  /// Atualiza professor e valida se a operação do banco de dados foi feita corretamente.
  @action
  updateTeacher(
      Teacher teacher,
      String name,
      PickedFile image,
      List<Project> projects,
      String link,
      ) async {
    var result = await TeacherFirestore.updateTeacher(teacher,name, image, projects, link);
    if(result){
      await getTeachers();
      return true;
    }else{
      return false;
    }
  }

  /// Deleta professor com base no identificador único.
  @action
  deleteTeacher(int id) async {
    await TeacherFirestore.deleteTeacher(id);
  }

  /// Recupera professor com base no identificador único.
  @action
  getTeacherById(String id) {
    var result = listTeachers!.value
        .where((element) => element.id.toString() == id)
        .toList();
    return result[0];
  }
}
