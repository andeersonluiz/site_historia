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
  ObservableFuture? listRecentPodcast;

  @observable
  ObservableFuture? listRecentNotices;

  @observable
  ObservableFuture? listSliders;

  @observable
  bool isEditting = false;

  @action
  getNotices() async {
    listNotices = ObservableFuture(NoticeFirestore.getNotices());
  }

  @action
  getNoticeById(String id) async {
    var result = listNotices!.value.where((element) {
      return element.id.toString() == id;
    }).toList();
    if (result.isNotEmpty) {
      return result[0];
    } else {
      return null;
    }
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
    PickedFile? thumb,
    bool isTopHeader,
    String? content,
    String author,
  ) async {
    bool result = await NoticeFirestore.addNotice(
        title, subtitle, type, tag, thumb, isTopHeader, content, author);
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
}
