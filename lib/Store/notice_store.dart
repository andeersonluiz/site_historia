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
  @observable
  ObservableFuture? listNotices;

  @observable
  ObservableFuture? listNoticesFiltered;

  @observable
  ObservableFuture? listRecentPodcast;

  @observable
  ObservableFuture? listRecentNotices;

  @observable
  ObservableFuture? listSliders;

  @observable
  bool isEditting = false;

  @observable
  String barSelected = "Tudo";

  @action
  getNotices() async {
    listNotices = ObservableFuture(NoticeFirestore.getNotices());
    listNoticesFiltered = listNotices;
  }

  @action
  getNoticeById(String id) {
    var result = listNotices!.value.where((element) {
      return element.id.toString() == id;
    }).toList();
    return result[0];
  }

  @action
  getRecentNotices() async {
    listRecentNotices = ObservableFuture(NoticeFirestore.getRecentNotices());
  }

  @action
  getRecentPodcasts() async {
    listRecentPodcast = ObservableFuture(NoticeFirestore.getRecentPodcasts());
  }

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

  deleteNotice(int id) {
    NoticeFirestore.deleteNotice(id);
  }

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

  updateNotices(List<Notice> notices) {
    NoticeFirestore.updateNotices(notices);
  }

  getSliders() async {
    listSliders = ObservableFuture(NoticeFirestore.getSliders());
  }

  verifyTopHeaders(Notice notice, bool value) {
    List<Notice> listNoticesTemp = listNotices!.value;
    var values = listNoticesTemp
        .where((element) => element.isTopHeader == true)
        .toList();
    if (values.length == GlobalsVariables.sizeCaurosel && value) {
      int index = listNotices!.value.indexOf(values[0]);
      listNotices!.value[index].isTopHeader = false;
    }
    int index = listNotices!.value.indexOf(notice);

    listNotices!.value[index].isTopHeader = value;

    List<Notice> l = listNotices!.value.toList();

    listNotices = ObservableFuture.value(l);
  }

  @action
  changeEddting() {
    this.isEditting = !isEditting;
  }

  @action
  updateMenuBar(String newItem) {
    this.barSelected = newItem;
  }

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

  convertBase64ToUrl(
    String filename,
    Uint8List base64,
    String id,
  ) async {
    return await NoticeFirestore.convertBase64ToUrl(filename, base64, id);
  }

  removeFilename(
    String filename,
    String id,
  ) async {
    return await NoticeFirestore.removeFilename(filename, id);
  }

  getNextId() async {
    return await NoticeFirestore.getNextId();
  }

  clearContent(String id, {DateTime? time}) {
    return NoticeFirestore.clearContent(id, time: time);
  }
}
