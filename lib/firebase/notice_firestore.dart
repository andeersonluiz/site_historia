/// Classe responsável realizar as operações do objeto `Notice` no banco de dados.
///
/// {@category Firebase}
// ignore: library_names
library NoticeFirestore;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Model/notice_model.dart';
import 'package:firebase/firebase.dart';

class NoticeFirestore {

  /// Retorna todos as notícias do banco de dados.
  static getNotices() async {
    var query = firestore().collection("notices");
    var result = await query.get();
    final results = result.docs;
    results.sort((b, a) {
      return a.data()['id'].compareTo(b.data()['id']);
    });
    List<Notice> notices = [];
    results.forEach((item) {
      notices.add(Notice.fromJson(item.data()));
    });
    return notices;
  }

  /// Retorna as notícias que retornam verdadeiro a condição `type==Podcast`.
  static getRecentPodcasts() async {
    var query =
        firestore().collection("notices").where('type', "==", "Podcast");
    var result = await query.get();
    final results = result.docs;
    results.sort((b, a) {
      return a.data()['id'].compareTo(b.data()['id']);
    });
    List<Notice> podcasts = [];
    int indexMax = results.length > 3 ? 3 : results.length;
    for (int i = 0; i < indexMax; i++) {
      podcasts.add(Notice.fromJson(results[i].data()));
    }
    return podcasts;
  }

  /// Retorna as notícias que retornam verdadeiro a condição `type==Noticia`.
  static getRecentNotices() async {
    var query =
        firestore().collection("notices").where('type', "==", "Noticia");
    var result = await query.get();
    final results = result.docs;
    results.sort((b, a) {
      return a.data()['id'].compareTo(b.data()['id']);
    });
    List<Notice> notices = [];
    int indexMax = results.length > 3 ? 3 : results.length;
    for (int i = 0; i < indexMax; i++) {
      notices.add(Notice.fromJson(results[i].data()));
    }
    return notices;
  }

  /// Atualiza o valor `isTopHeader` às notícias.
  static updateNotices(List<Notice> notices) async {
    await firestore()
        .collection("notices")
        .get()
        .then((value) => value.docs.forEach((document) async {
              for (int i = 0; i < notices.length; i++) {
                if (notices[i].id == document.data()['id'] &&
                    notices[i].isTopHeader != document.data()['isTopHeader']) {
                  await firestore()
                      .collection("notices")
                      .doc(notices[i].id.toString())
                      .update(data: notices[i].toJson());
                  break;
                }
              }
            }));

    return;
  }

  /// Adiciona uma notícia no banco de dados.
  static addNotice(
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
    try {
      var values = await firestore().collection("notices").get();
      int nextId = values.docs.length + 1;

      var metadata = await thumb!.readAsBytes();

      var task = await storage()
          .ref()
          .child("notices/$nextId.png")
          .put(metadata, UploadMetadata(contentType: 'image/jpg'))
          .future;
      Uri urlImage = await task.ref.getDownloadURL();

      Uri urlAudio = Uri.parse("");
      String nameAudio = "";
      if (audio.name != null && type == "Podcast") {
        metadata = audio.bytes!;
        nameAudio = audio.name!;
        task = await storage()
            .ref()
            .child("notices/$nextId(audio).mp3")
            .put(metadata, UploadMetadata(contentType: 'audio/mp3'))
            .future;
        urlAudio = await task.ref.getDownloadURL();
      }
      Notice notice = Notice(
          id: nextId,
          title: title,
          subtitle: subtitle,
          tag: tag,
          type: type,
          audio: [nameAudio, urlAudio.toString()],
          thumb: urlImage.toString(),
          datePost: DateFormat("dd-MM-yyyy hh:mm").format(DateTime.now()),
          content: content.toString(),
          views: 0,
          isTopHeader: isTopHeader,
          author: author);
      firestore()
          .collection("notices")
          .doc(nextId.toString())
          .set(notice.toJson());
    } catch (e) {
      return false;
    }
    return true;
  }

  /// Atualiza uma notícia no banco de dados.
  static updateNotice(
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
    try {
      Uri urlImage = Uri.parse(thumb!.path.toString());
      if (!thumb.path.contains("firebasestorage")) {
        var metadata = await thumb.readAsBytes();
        UploadTaskSnapshot task = await storage()
            .ref()
            .child("notices/${notice.id}.png")
            .put(metadata, UploadMetadata(contentType: 'image/jpg'))
            .future;
        urlImage = await task.ref.getDownloadURL();
      }

      if (audio.name != "" && audio.bytes != null) {
        var metadata = audio.bytes;
        UploadTaskSnapshot task = await storage()
            .ref()
            .child("notices/${notice.id}(audio).mp3")
            .put(metadata, UploadMetadata(contentType: 'audio/mp3'))
            .future;
        var result = await task.ref.getDownloadURL();
        notice.audio[0] = result.toString();
        notice.audio[0] = audio.name!;
      }

      Notice newNotice = Notice(
          id: notice.id,
          title: title,
          subtitle: subtitle,
          tag: tag,
          audio: [notice.audio[0], notice.audio[1]],
          type: type,
          thumb: urlImage.toString(),
          datePost: DateFormat("dd-MM-yyyy hh:mm").format(DateTime.now()),
          content: content.toString(),
          views: views,
          isTopHeader: isTopHeader,
          author: author);
      await firestore()
          .collection("notices")
          .doc(newNotice.id.toString())
          .update(data: newNotice.toJson());
    } catch (e) {
      return false;
    }
    return true;
  }

  /// Exclui uma notícia do banco de dados.
  static deleteNotice(int id) async {
    await firestore().collection("notices").doc(id.toString()).delete();
    await storage().ref().child("notices/$id.png").delete();
    await storage().ref().child("notices/$id(audio).mp3").delete();
    return;
  }

  /// Retorna as notícias com a condição `isTopHeader=true`.
  static getSliders() async {
    var query = firestore()
        .collection("notices")
        .where('isTopHeader', "==", true)
        .limit(5);
    var result = await query.get();
    List<Notice> topheaders = [];
    result.docs.forEach((item) {
      topheaders.add(Notice.fromJson(item.data()));
    });
    return topheaders;
  }

  /// Insere uma imagem no banco de dados, na seção de notícias, e retorna a url da mesma.
  static convertBase64ToUrl(
      String fileName, Uint8List base64, String id) async {
    UploadTaskSnapshot task = await storage()
        .ref()
        .child("notices/$id(content)/$fileName")
        .put(base64, UploadMetadata(contentType: 'image/jpg'))
        .future;
    var url = await task.ref.getDownloadURL();
    return url.toString();
  }

  /// Remove uma imagem da seção de notícias no banco de dados.
  static removeFilename(String fileName, String id) async {
    await storage().ref("notices/$id(content)/$fileName").delete();
  }

  /// Recebe o próximo id que será utilizado na inserção de um notícia.
  static getNextId() async {
    var result = await firestore().collection("notices").get();
    return result.docs.length + 1;
  }

  /// Validador para excluir a(s) imagem(s) caso o usuário não crie a notícia.
  ///
  /// A cada inserção de imagem do usuário durante a criação/edição de texto, as imagens são salvas dentro do banco de dados.
  /// A função é executada se o usuário inserir imagens mas não criar a notícia.
  static clearContent(String id, {DateTime? time}) async {
    var result = await storage().ref().child("notices/$id(content)").listAll();
    if (time != null) {
      for (int i = 0; i < result.items.length; i++) {
        FullMetadata metadata = await result.items[i].getMetadata();
        if (metadata.timeCreated.isAfter(time)) {
          storage()
              .ref()
              .child("notices/$id(content)/${result.items[i].name}")
              .delete();
        }
      }
    } else {
      for (int i = 0; i < result.items.length; i++) {
        storage()
            .ref()
            .child("notices/$id(content)/${result.items[i].name}")
            .delete();
      }
    }
  }
}
