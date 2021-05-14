import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:site_historia/Model/frame_model.dart';
import 'package:site_historia/firebase/frame_firestore.dart';

part 'frame_store.g.dart';

class FrameStore = _FrameStoreBase with _$FrameStore;

abstract class _FrameStoreBase with Store {
  @observable
  ObservableFuture? listFrames;

  @observable
  ObservableList listFramesOrdered = ObservableList.of([]);

  @action
  getFrames() async {
    listFrames = ObservableFuture(FrameFirestore.getFrames());
  }

  @action
  addFrame(
    String title,
    String subtitle,
    PickedFile? imageHeader,
    String? content,
    PlatformFile audio,
    dynamic video,
    String author,
  ) async {
    bool result = await FrameFirestore.addFrame(
        title, subtitle, imageHeader, content, audio, video, author);
    if (result) {
      await getFrames();
      return true;
    } else {
      return false;
    }
  }

  @action
  updateFrame(
    Frame frame,
    String title,
    String subtitle,
    PickedFile? imageHeader,
    String? content,
    PlatformFile audio,
    dynamic video,
    int views,
    String author,
  ) async {
    bool result = await FrameFirestore.updateFrame(frame, title, subtitle,
        imageHeader, content, audio, video, views, author);
    if (result) {
      await getFrames();
      return true;
    } else {
      return false;
    }
  }

  @action
  deleteFrame(int id) async {
    FrameFirestore.deleteFrame(id);
  }

  @action
  getFrameById(String id) {
    var result = listFrames!.value.where((element) {
      return element.id.toString() == id;
    }).toList();
    return result[0];
  }

  @action
  getFramesSortedByTitle() async {
    var result = await FrameFirestore.getFramesSortedByTitle();
    listFramesOrdered = ObservableList.of(result);
  }
}
