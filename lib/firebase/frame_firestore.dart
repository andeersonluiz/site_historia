import '../model/frame_model.dart';
import 'package:firebase/firebase.dart';

class FrameFirestore {
  late List<Frame> listFramesOrdenedByName = [];

  getFrames() async {
    var query = firestore().collection("frames").orderBy('id');
    var result = await query.get();
    final results = result.docs;
    List<Frame> listFrames = [];
    results.forEach((item) {
      listFrames.add(Frame.fromJson(item.data()));
    });
    return listFrames;
  }

  getFramesName() async {
    var query = firestore().collection("frames").orderBy('name');
    var result = await query.get();
    result.docs.forEach((item) {
      listFramesOrdenedByName.add(Frame.fromJson(item.data()));
    });
  }
}
