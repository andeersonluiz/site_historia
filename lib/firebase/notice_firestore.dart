import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Model/notice_model.dart';
import 'package:firebase/firebase.dart';

class NoticeFirestore {
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

  static deleteNotice(int id) async {
    await firestore().collection("notices").doc(id.toString()).delete();
    return;
  }

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

  static addNotice(
    String title,
    String subtitle,
    String type,
    String tag,
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
      Uri url = await task.ref.getDownloadURL();

      Notice notice = Notice(
          id: nextId,
          title: title,
          subtitle: subtitle,
          tag: tag,
          type: type,
          thumb: url.toString(),
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

  Future<String> getHeadNotice(String idNotice) async {
    ListResult result = await storage()
        .ref()
        .child("notices")
        .child(idNotice)
        .child("head")
        .listAll();
    Uri url = await result.items.first.getDownloadURL();
    return url.toString();
  }
}
