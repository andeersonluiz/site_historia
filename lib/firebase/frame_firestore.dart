import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/frame_model.dart';

class FrameFirestore {
  late List<Frame> listFramesOrdenedByName = [];

  getFrames() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    Query query = instance.collection("frames").orderBy('id');
    QuerySnapshot result = await query.get();
    final results = result.docs;
    List<Frame> listFrames = [];
    results.forEach((item) {
      listFrames.add(Frame.fromJson(item.data()));
    });
    return listFrames;
  }

  getFramesName() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    Query query = instance.collection("frames").orderBy('name');
    QuerySnapshot result = await query.get();
    result.docs.forEach((item) {
      listFramesOrdenedByName.add(Frame.fromJson(item.data()));
    });
  }
}
