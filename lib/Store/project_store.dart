/// Store responsável sobre as informações de projetos.
///
/// {@category Store}
// ignore: library_names
library ProjectStore;
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:site_historia/firebase/project_firestore.dart';

part 'project_store.g.dart';

class ProjectStore = _ProjectStoreBase with _$ProjectStore;

abstract class _ProjectStoreBase with Store {
  /// Variável que armazena localmente a lista de projetos.
  @observable
  ObservableFuture? listProjects;

  /// Variável que armazena a lista de projetos ordenada de acordo com o título.
  @observable
  ObservableList listProjectsOrdered = ObservableList.of([]);

  /// Retorna os projetos do banco de dados.
  @action
  getProjects() async {
    listProjects = ObservableFuture(ProjectFirestore.getProjects());
  }

  /// Retorna um projeto através de um identificador único.
  @action
  getProjectById(String id) {
    var result = listProjects!.value
        .where((element) => element.id.toString() == id)
        .toList();
    return result[0];
  }

  /// Adiciona um projeto ao banco de dados.
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

  /// Atualiza um projeto no banco de dados.
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

  /// Exclui um projeto do banco de dados.
  deleteProject(int id) {
    ProjectFirestore.deleteProject(id);
  }

  /// Retorna o nome do usuário que está logado.
  getUsernameByUid(String uid) async {
    if (GlobalsVariables.username == "") {
      String name = await ProjectFirestore.getUsernameByUid(uid);
      GlobalsVariables.username = name;
    }
    return GlobalsVariables.username;
  }

  /// Retorna a lista de projetos ordenado por título.
  getProjectSortedByTitle() async {
    var result = await ProjectFirestore.getProjectSortedByTitle();
    listProjectsOrdered = ObservableList.of(result);
  }

  /// Recebe um arquivo de imagem em base64, adiciona ao banco de dados e retorna a url.
  convertBase64ToUrl(
      String filename,
      Uint8List base64,
      String id,
      ) async {
    return await ProjectFirestore.convertBase64ToUrl(filename, base64, id);
  }

  /// Remove um arquivo de imagem do banco de dados.
  removeFilename(
    String filename,
    String id,
  ) async {
    return await ProjectFirestore.removeFilename(filename, id);
  }

  /// Retorna o próximo id a ser adicionado no banco de dados;
  getNextId() async {
    return await ProjectFirestore.getNextId();
  }

  /// Validador para excluir a(s) imagem(s) caso o usuário não crie o projeto.
  ///
  /// A cada inserção de imagem do usuário durante a criação/edição de texto, as imagens são salvas dentro do banco de dados.
  /// A função é executada se o usuário inserir imagens mas não criar o projeto.
  clearContent(String id, {DateTime? time}) {
    return ProjectFirestore.clearContent(id, time: time);
  }
}
