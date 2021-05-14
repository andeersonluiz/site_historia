import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:firebase/firebase.dart';
import 'package:site_historia/Model/frame_model.dart';

class FrameFirestore {
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

  static getFramesSortedByTitle() async {
    var query = firestore().collection("frames").orderBy('title');
    var result = await query.get();
    List<Frame> listFramesOrderedByName = [];
    result.docs.forEach((item) {
      listFramesOrderedByName.add(Frame.fromJson(item.data()));
    });
    return listFramesOrderedByName;
  }

  static Future<bool> addFrame(
    String title,
    String subtitle,
    PickedFile? imageHeader,
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
      if (audio.name != null) {
        metadata = audio.bytes!;
        nameAudio = audio.name!;
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
        if (video.name != null) {
          metadata = video.bytes!;
          nameVideo = video.name!;
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

  static Future<bool> updateFrame(
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
        nameAudio = audio.name!;
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
          nameVideo = video.name!;
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

  static deleteFrame(int id) async {
    await firestore().collection("frames").doc(id.toString()).delete();
    await storage().ref().child("frames/$id.png").delete();
    await storage().ref().child("frames/$id(audio).mp3").delete();
    await storage().ref().child("frames/$id(video).mp4").delete();
    return;
  }
}
