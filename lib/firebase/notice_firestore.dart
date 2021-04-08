import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:site_historia/model/notice_model.dart';

class NoticeFirestore {
  getNotices() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    Query query =
        instance.collection("notices").where('tag', isNotEqualTo: "Podcast");
    QuerySnapshot result = await query.get();
    /*
    for(int i=3;i<=6;i++){
      print("xuuu");
      String url = await getHeadNotice("notice1");
      print("uuu");
      List<String> urls = await getContentNotice("notice1");
     // print(url+", "+ urls[0]);

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
      return a['id'].compareTo(b['id']);
    });
    List<Notice> notices = [];
    results.forEach((item) {
      print(item.data());
      notices.add(Notice.fromJson(item.data()));
    });
    return notices;
  }

  getPodcasts() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    Query query =
        instance.collection("notices").where('tag', isEqualTo: "Podcast");
    QuerySnapshot result = await query.get();
    final results = result.docs;
    results.sort((b, a) {
      return a['id'].compareTo(b['id']);
    });
    List<Notice> podcasts = [];
    results.forEach((item) {
      print(item.data());
      podcasts.add(Notice.fromJson(item.data()));
    });
    return podcasts;
  }

  getSliders() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    Query query = instance
        .collection("notices")
        .where('isTopHeader', isEqualTo: true)
        .limit(5);
    QuerySnapshot result = await query.get();
    print("Uuuux");
    List<Notice> topheaders = [];
    result.docs.forEach((item) {
      print(item.data());
      topheaders.add(Notice.fromJson(item.data()));
    });
    return topheaders;
  }

  Future<String> getHeadNotice(String idNotice) async {
    ListResult result = await FirebaseStorage.instance
        .ref()
        .child(idNotice)
        .child("head")
        .listAll();
    String url = await result.items.first.getDownloadURL();
    return url;
  }

  Future<List<String>> getContentNotice(String idNotice) async {
    ListResult result = await FirebaseStorage.instance
        .ref()
        .child(idNotice)
        .child("content")
        .listAll();
    List<String> urls = [];
    result.items.forEach((item) async {
      urls.add(await item.getDownloadURL());
    });
    return urls;
  }
}
