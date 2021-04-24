import '../model/notice_model.dart';
import 'package:firebase/firebase.dart';

class NoticeFirestore {
  getNotices() async {
    var query = firestore().collection("notices").where('tag', "!=", "Podcast");
    var result = await query.get();
    /*
    for(int i=3;i<=6;i++){
      String url = await getHeadNotice(i.toString());
      List<String> urls = await getContentNotice(i.toString());

    instance.collection("notices").doc(i.toString()).set(
    {
      'id': i,
      'views': 0,
      'tag':"Estudo",
     'datePost': DateTime.now(),
      'content':' Texto da noticia $i', 
      'title':' Noticia $i', 
      'imageContent': urls, 'imageHeader':url , 'subtitle': "Subtitulo notice 1",'isTopHeader':true}
  );
  }*/
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

  getPodcasts() async {
    var query = firestore().collection("notices").where('tag', "==", "Podcast");
    var result = await query.get();
    final results = result.docs;
    results.sort((b, a) {
      return a.data()['id'].compareTo(b.data()['id']);
    });
    List<Notice> podcasts = [];
    results.forEach((item) {
      podcasts.add(Notice.fromJson(item.data()));
    });
    return podcasts;
  }

  getSliders() async {
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
