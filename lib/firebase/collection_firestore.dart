/// Classe responsável realizar as operações do objeto `Collection` no banco de dados.
///
/// {@category Firebase}
// ignore: library_names
library CollectionFirestore;
import 'package:file_picker/file_picker.dart';
import 'package:firebase/firebase.dart';
import 'package:site_historia/Model/collection_model.dart';

class CollectionFirestore {
  /// Retorna o acervo do banco de dados.
  static getCollections() async {
    var query = firestore().collection("collections");
    var results = await query.get();
    final result = results.docs[0];
    Collection collections = Collection.fromJson(result.data());
    return collections;
  }

  /// Atualiza o acervo no banco de dados.
  static updateCollection(Collection collection) async {
    await firestore()
        .collection("collections")
        .doc("0")
        .update(data: collection.toJson());
  }

  static insertFile(String type, PlatformFile file, int id) async {
    var metadata = file.bytes;
    var extension = file.name!.split(".").last;
    var fileName = file.name!.split(extension)[0];
    fileName = fileName.substring(0, fileName.length - 1);
    var result = await storage().ref("collections/$type").listAll();
    for (int i = 0; i < result.items.length; i++) {
      if (result.items[i].name.contains("((${id}544644))")) {
        storage().ref("collections/$type/${result.items[i].name}").delete();
      }
    }

    if (!fileName.contains("((${id}544644))")) {
      fileName = fileName + "((${id}544644))";
    }

    var uri = await storage()
        .ref("collections/$type/$fileName.$extension")
        .put(metadata)
        .future;
    return await uri.ref.getDownloadURL();
  }

  static removeFile(String type, String fileName, int id) async {
    fileName = fileName.substring(0, fileName.length - 1);
    var extension = fileName.split(".").last;

    await await storage()
        .ref("collections/$type/$fileName((${id}544644)).$extension")
        .delete();
  }
}
