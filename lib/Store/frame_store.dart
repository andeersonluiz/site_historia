/// Store responsável sobre as informações de quadros.
///
/// {@category Store}
// ignore: library_names
library FrameStore;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:site_historia/Model/frame_model.dart';
import 'package:site_historia/firebase/frame_firestore.dart';

part 'frame_store.g.dart';

class FrameStore = _FrameStoreBase with _$FrameStore;

abstract class _FrameStoreBase with Store {
  /// Variável que armazena a lista de quadros.
  @observable
  ObservableFuture? listFrames;

  /// Variável que armazena a lista de quadros ordenada de acordo com o título.
  @observable
  ObservableList listFramesOrdered = ObservableList.of([]);

  /// Retorna os quadros do banco de dados.
  @action
  getFrames() async {
    listFrames = ObservableFuture(FrameFirestore.getFrames());
  }

  /// Adiciona um quadro ao banco de dados.
  @action
  addFrame(
    String title,
    String subtitle,
    PickedFile? imageHeader,
    String subtitleImage,
    String? content,
    PlatformFile audio,
    dynamic video,
    String author,
  ) async {
    bool result = await FrameFirestore.addFrame(title, subtitle, imageHeader,
        subtitleImage, content, audio, video, author);
    if (result) {
      await getFrames();
      return true;
    } else {
      return false;
    }
  }

  /// Atualiza um quadro no banco de dados.
  @action
  updateFrame(
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
    bool result = await FrameFirestore.updateFrame(frame, title, subtitle,
        imageHeader, subtitleImage, content, audio, video, views, author);
    if (result) {
      await getFrames();
      return true;
    } else {
      return false;
    }
  }

  /// Exclui um quadro do banco de dados.
  @action
  deleteFrame(int id) async {
    await FrameFirestore.deleteFrame(id);
  }

  /// Retorna um quadro através de um identificador único.
  @action
  getFrameById(String id) {
    var result = listFrames!.value.where((element) {
      return element.id.toString() == id;
    }).toList();
    return result[0];
  }

  /// Retorna a lista de quadro ordenado por título.
  @action
  getFramesSortedByTitle() async {
    var result = await FrameFirestore.getFramesSortedByTitle();
    listFramesOrdered = ObservableList.of(result);
  }

  /// Recebe um arquivo de imagem em base64, adiciona ao banco de dados e retorna a url.
  convertBase64ToUrl(
    String filename,
    Uint8List base64,
    String id,
  ) async {
    return await FrameFirestore.convertBase64ToUrl(filename, base64, id);
  }

  /// Remove um arquivo de imagem do banco de dados.
  removeFilename(
    String filename,
    String id,
  ) async {
    return await FrameFirestore.removeFilename(filename, id);
  }

  /// Retorna o próximo id a ser adicionado no banco de dados;
  getNextId() async {
    return await FrameFirestore.getNextId();
  }

  /// Validador para excluir a(s) imagem(s) caso o usuário não crie o quadro.
  ///
  /// A cada inserção de imagem do usuário durante a criação/edição de texto, as imagens são salvas dentro do banco de dados.
  /// A função é executada se o usuário inserir imagens mas não criar o projeto.
  clearContent(String id, {DateTime? time}) {
    return FrameFirestore.clearContent(id, time: time);
  }
}
