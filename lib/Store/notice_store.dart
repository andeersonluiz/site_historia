/// Store responsável sobre as informações de notícias.
///
/// {@category Store}
// ignore: library_names
library NoticeStore;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:site_historia/firebase/notice_firestore.dart';

part 'notice_store.g.dart';

class NoticeStore = _NoticeStoreBase with _$NoticeStore;

abstract class _NoticeStoreBase with Store {
  /// Variável que armazena a lista de notícias.
  @observable
  ObservableFuture? listNotices;

  /// Variável gerencia a lista de notícias de acordo com o filtro estabelecido.
  @observable
  ObservableFuture? listNoticesFiltered;

  /// Variável que recebe as notícias que são `Podcast`.
  @observable
  ObservableFuture? listRecentPodcast;

  /// Variável que recebe as noticias que são `Noticia`.
  @observable
  ObservableFuture? listRecentNotices;

  /// Variável que armazena as notícias que possuem `isTopHeader = true`
  @observable
  ObservableFuture? listSliders;

  /// Variável que faz o controle da edição dos menus que ficam na página inicial.
  @observable
  bool isEditing = false;

  /// Variável controla a seleção de filtros, há três opções (Tudo, Podcast e Notícia)
  /// por padrão, o valor inicial é "Tudo".
  @observable
  String barSelected = "Tudo";

  /// Retorna as notícias do banco de dados.
  @action
  getNotices() async {
    listNotices = ObservableFuture(NoticeFirestore.getNotices());
    listNoticesFiltered = listNotices;
  }

  /// Retorna uma notícia através de um identificador único.
  @action
  getNoticeById(String id) {
    var result = listNotices!.value.where((element) {
      return element.id.toString() == id;
    }).toList();
    return result[0];
  }

  /// Retorna as três notícias mais recentes.
  @action
  getRecentNotices() async {
    listRecentNotices = ObservableFuture(NoticeFirestore.getRecentNotices());
  }

  /// Retorna as três podcasts mais recentes.
  @action
  getRecentPodcasts() async {
    listRecentPodcast = ObservableFuture(NoticeFirestore.getRecentPodcasts());
  }

  /// Adiciona uma notícia ao banco de dados.
  addNotice(
      String title,
      String subtitle,
      String type,
      String tag,
      PlatformFile audio,
      PickedFile? thumb,
      bool isTopHeader,
      String? content,
      String author,
      ) async {
    bool result = await NoticeFirestore.addNotice(
        title, subtitle, type, tag, audio, thumb, isTopHeader, content, author);
    if (result) {
      await getNotices();
      return true;
    } else {
      return false;
    }
  }

  /// Exclui uma notícia do banco de dados.
  deleteNotice(int id) {
    NoticeFirestore.deleteNotice(id);
  }

  /// Atualiza uma notícia no banco de dados.
  updateNotice(
      Notice notice,
      String title,
      String subtitle,
      String type,
      String tag,
      PlatformFile audio,
      PickedFile? thumb,
      bool isTopHeader,
      String? content,
      int views,
      String author,
      ) async {
    var result = await NoticeFirestore.updateNotice(notice, title, subtitle,
        type, tag, audio, thumb, isTopHeader, content, views, author);
    if (result) {
      await getNotices();
      return true;
    } else {
      return false;
    }
  }

  /// Atualiza uma lista de notícias no banco de dados.
  updateNotices(List<Notice> notices) {
    NoticeFirestore.updateNotices(notices);
  }

  /// Retorna as notícias que possuem `isTopHeader = true`.
  getSliders() async {
    listSliders = ObservableFuture(NoticeFirestore.getSliders());
  }

  /// Controla a adição de remoção de notícias para página inicial,
  /// o número máximo é definido através da variável `GlobalsVariables.sizeCarousel`.
  verifyTopHeaders(Notice notice, bool value) {
    List<Notice> listNoticesTemp = listNotices!.value;
    var values = listNoticesTemp
        .where((element) => element.isTopHeader == true)
        .toList();
    if (values.length == GlobalsVariables.sizeCarousel && value) {
      int index = listNotices!.value.indexOf(values[0]);
      listNotices!.value[index].isTopHeader = false;
    }
    int index = listNotices!.value.indexOf(notice);

    listNotices!.value[index].isTopHeader = value;

    List<Notice> l = listNotices!.value.toList();

    listNotices = ObservableFuture.value(l);
  }

  /// Atualiza a variável isEditing.
  @action
  changeEditing() {
    this.isEditing = !isEditing;
  }

  /// Atualiza a variável barSelected.
  @action
  updateMenuBar(String newItem) {
    this.barSelected = newItem;
  }

  /// Filtra as notícias de acordo com o valor.
  @action
  filterListNotices(String value) {
    if (value == "Tudo") {
      listNoticesFiltered =
          ObservableFuture(Future.delayed(Duration(milliseconds: 300), () {
            return listNotices!.value;
          }));
    } else {
      List<Notice> listNoticesTemp = listNotices!.value;

      var values =
      listNoticesTemp.where((element) => element.tag == value).toList();

      List<Notice> l = values.toList();

      listNoticesFiltered =
          ObservableFuture(Future.delayed(Duration(milliseconds: 300), () {
            return l;
          }));
    }
  }

  /// Filtra a lista de notícias de acordo com a pesquisa.
  search(String searchText) {
    List<Notice> listNoticesTemp = listNotices!.value;

    var values = listNoticesTemp
        .where((element) =>
        element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    List<Notice> l = values.toList();

    listNoticesFiltered =
        ObservableFuture(Future.delayed(Duration(milliseconds: 300), () {
          return l;
        }));
  }

  /// Recebe um arquivo de imagem em base64, adiciona ao banco de dados e retorna a url.
  convertBase64ToUrl(
      String filename,
      Uint8List base64,
      String id,
      ) async {
    return await NoticeFirestore.convertBase64ToUrl(filename, base64, id);
  }

  /// Remove um arquivo de imagem do banco de dados.
  removeFilename(
      String filename,
      String id,
      ) async {
    return await NoticeFirestore.removeFilename(filename, id);
  }

  /// Retorna o próximo id a ser adicionado no banco de dados;
  getNextId() async {
    return await NoticeFirestore.getNextId();
  }

  /// Validador para excluir a(s) imagem(s) caso o usuário não crie a notícia.
  ///
  /// A cada inserção de imagem do usuário durante a criação/edição de texto, as imagens são salvas dentro do banco de dados.
  /// A função é executada se o usuário inserir imagens mas não criar o projeto.
  clearContent(String id, {DateTime? time}) {
    return NoticeFirestore.clearContent(id, time: time);
  }



}
