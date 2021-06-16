/// Classe responsável realizar as operações do objeto `Frame` no banco de dados.
///
/// {@category Firebase}
// ignore: library_names
library FrameFirestore;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:firebase/firebase.dart';
import 'package:site_historia/Model/frame_model.dart';

class FrameFirestore {
  /// Retorna todos os quadros do banco de dados.
  static getFrames() async {
    var query = firestore().collection("frames").orderBy('id');
    var result = await query.get();
    final results = result.docs;
    List<Frame> listFrames = [];
    results.forEach((item) {
      listFrames.add(Frame.fromJson(item.data()));
    });
    return listFrames;
  }
  /// Retorna todos os quadros do banco de dados, ordenados por título.
  static getFramesSortedByTitle() async {
    var query = firestore().collection("frames").orderBy('title');
    var result = await query.get();
    List<Frame> listFramesOrderedByName = [];
    result.docs.forEach((item) {
      listFramesOrderedByName.add(Frame.fromJson(item.data()));
    });
    return listFramesOrderedByName;
  }

  /// Adiciona um quadro ao banco de dados.
  static Future<bool> addFrame(
    String title,
    String subtitle,
    PickedFile? imageHeader,
    String subtitleImage,
    String? content,
    PlatformFile audio,
    dynamic video,
    String author,
  ) async {
    try {
      var result = await firestore().collection("frames").get();
      int nextId = result.docs.length + 1;

      var metadata = await imageHeader!.readAsBytes();
      UploadTaskSnapshot task = await storage()
          .ref()
          .child("frames/$nextId.png")
          .put(metadata, UploadMetadata(contentType: 'image/jpg'))
          .future;
      Uri url = await task.ref.getDownloadURL();

      Uri urlAudio = Uri.parse("");
      String nameAudio = "";
      if (audio.name != "") {
        metadata = audio.bytes!;
        nameAudio = audio.name;
        task = await storage()
            .ref()
            .child("frames/$nextId(audio).mp3")
            .put(metadata, UploadMetadata(contentType: 'audio/mp3'))
            .future;
        urlAudio = await task.ref.getDownloadURL();
      }

      Uri urlVideo = Uri.parse("");
      String nameVideo = "";
      if (video is PlatformFile) {
        if (video.name != "") {
          metadata = video.bytes!;
          nameVideo = video.name;
          task = await storage()
              .ref()
              .child("frames/$nextId(video).mp4")
              .put(metadata, UploadMetadata(contentType: 'video/mp4'))
              .future;
          urlVideo = await task.ref.getDownloadURL();
        }
      } else if (video != "") {
        urlVideo = Uri.parse(video);
        nameVideo = video;
      }
      Frame frame = Frame(
        id: nextId,
        title: title,
        subtitle: subtitle,
        subtitleImage: subtitleImage,
        imageHeader: url.toString(),
        content: content.toString(),
        datePost: DateFormat("dd-MM-yyyy hh:mm").format(DateTime.now()),
        urlVideo: [nameVideo, urlVideo.toString()],
        urlAudio: [nameAudio, urlAudio.toString()],
        author: author,
        views: 0,
      );
      await firestore()
          .collection("frames")
          .doc(nextId.toString())
          .set(frame.toJson());
    } catch (e) {
      return false;
    }
    return true;
  }

  /// Atualiza um quadro no banco de dados.
  static Future<bool> updateFrame(
    Frame frame,
    String title,
    String subtitle,
    PickedFile? imageHeader,
    String subtitleImage,
    String? content,
    PlatformFile audio,
    dynamic video,
    int views,
    String author,
  ) async {
    try {
      Uri urlImage = Uri.parse(imageHeader!.path.toString());
      if (!imageHeader.path.contains("firebasestorage")) {
        var metadata = await imageHeader.readAsBytes();
        UploadTaskSnapshot task = await storage()
            .ref()
            .child("notices/${frame.id}.png")
            .put(metadata, UploadMetadata(contentType: 'image/jpg'))
            .future;
        urlImage = await task.ref.getDownloadURL();
      }

      String nameAudio = frame.urlAudio[0];
      String urlAudio = frame.urlAudio[1];

      if (audio.name != "" && audio.bytes != null) {
        var metadata = audio.bytes;
        UploadTaskSnapshot task = await storage()
            .ref()
            .child("notices/${frame.id}(audio).mp3")
            .put(metadata, UploadMetadata(contentType: 'audio/mp3'))
            .future;
        var result = await task.ref.getDownloadURL();
        nameAudio = audio.name;
        urlAudio = result.toString();
      }

      String nameVideo = frame.urlVideo[0];
      String urlVideo = frame.urlVideo[1];
      if (video is PlatformFile) {
        if (video.name != "" && video.bytes != null) {
          var metadata = video.bytes!;
          var task = await storage()
              .ref()
              .child("frames/${frame.id}(video).mp4")
              .put(metadata, UploadMetadata(contentType: 'video/mp4'))
              .future;
          var result = await task.ref.getDownloadURL();
          nameVideo = video.name;
          urlVideo = result.toString();
        }
      } else if (video != "") {
        nameVideo = video;
        urlVideo = Uri.parse(video).toString();
      }

      Frame newFrame = Frame(
          id: frame.id,
          title: title,
          subtitle: subtitle,
          urlAudio: [nameAudio, urlAudio],
          urlVideo: [nameVideo, urlVideo],
          imageHeader: urlImage.toString(),
          subtitleImage: subtitleImage,
          datePost: DateFormat("dd-MM-yyyy hh:mm").format(DateTime.now()),
          content: content.toString(),
          views: frame.views,
          author: author);
      await firestore()
          .collection("frames")
          .doc(newFrame.id.toString())
          .update(data: newFrame.toJson());
    } catch (e) {
      return false;
    }
    return true;
  }

  /// Exclui um quadro do banco de dados.
  static deleteFrame(int id) async {
    await firestore().collection("frames").doc(id.toString()).delete();
    await storage().ref().child("frames/$id.png").delete();
    await storage().ref().child("frames/$id(audio).mp3").delete();
    await storage().ref().child("frames/$id(video).mp4").delete();
    return;
  }

  /// Insere uma imagem no banco de dados, na seção de quadros , e retorna a url da mesma.
  static convertBase64ToUrl(
      String fileName, Uint8List base64, String id) async {
    UploadTaskSnapshot task = await storage()
        .ref()
        .child("frames/$id(content)/$fileName")
        .put(base64, UploadMetadata(contentType: 'image/jpg'))
        .future;
    var url = await task.ref.getDownloadURL();
    return url.toString();
  }
  /// Remove uma imagem da seção de quadros no banco de dados.
  static removeFilename(String fileName, String id) async {
    await storage().ref("frames/$id(content)/$fileName").delete();
  }

  /// Recebe o próximo id que será utilizado na inserção de um quadro.
  static getNextId() async {
    var result = await firestore().collection("frames").get();
    return result.docs.length + 1;
  }

  /// Validador para excluir a(s) imagem(s) caso o usuário não crie o quadro.
  ///
  /// A cada inserção de imagem do usuário durante a criação/edição de texto, as imagens são salvas dentro do banco de dados.
  /// A função é executada se o usuário inserir imagens mas não criar o quadro.
  static clearContent(String id, {DateTime? time}) async {
    var result = await storage().ref().child("frames/$id(content)").listAll();
    if (time != null) {
      for (int i = 0; i < result.items.length; i++) {
        FullMetadata metadata = await result.items[i].getMetadata();
        if (metadata.timeCreated.isAfter(time)) {
          storage()
              .ref()
              .child("frames/$id(content)/${result.items[i].name}")
              .delete();
        }
      }
    } else {
      for (int i = 0; i < result.items.length; i++) {
        storage()
            .ref()
            .child("frames/$id(content)/${result.items[i].name}")
            .delete();
      }
    }
  }
}
