import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/frame_model.dart';

class FrameFirestore {
  late List<String> listFrames = [];

  getFrames() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    Query query = instance.collection("frames").orderBy('id');
    QuerySnapshot result = await query.get();
    final results = result.docs;
    List<Frame> notices = [];
    results.forEach((item) {
      notices.add(Frame.fromJson(item.data()));
    });
    return notices;
  }

  getFramesName() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    Query query = instance.collection("frames").orderBy('name');
    QuerySnapshot result = await query.get();
    result.docs.forEach((item) {
      listFrames.add(item['name']);
    });
  }
}
