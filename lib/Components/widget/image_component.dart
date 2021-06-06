/// Widget responsável por exibir a seleção de imagem na adição de imagem na página do admin.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library ImageWidget;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Store/support_store.dart';

class ImageWidget extends StatelessWidget {
  /// Controle para verificar se é um projeto.
  final bool isProject;
  /// Variável que captura a imagem.
  final PickedFile? image;
  /// Título do projeto, exibido caso `isProject=true`.
  final String? titleProject;
  ImageWidget({required this.image, this.isProject = false, this.titleProject});
  @override
  Widget build(BuildContext context) {
    final supportStore = Provider.of<SupportStore>(context);
    final _picker = ImagePicker();
    return Container(
      width: MediaQuery.of(context).size.width -
          MediaQuery.of(context).padding.horizontal -
          MediaQuery.of(context).viewInsets.right,
      decoration: image!.path != ""
          ? BoxDecoration(
              image: DecorationImage(
              image: NetworkImage(image!.path),
              fit: BoxFit.fill,
            ))
          : BoxDecoration(color: Colors.grey),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: !isProject
              ? [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        child: Icon(Icons.folder),
                        onTap: () async {
                          PickedFile? image;
                          if (!kIsWeb) {
                            image = await _picker.getImage(
                                source: ImageSource.gallery);
                          } else {
                            image = await _picker.getImage(
                                source: ImageSource.camera);
                          }
                          if (image != null) {
                            supportStore.updatePath(image);
                          }
                        }),
                  ),
                ]
              : [
                  image!.path != ""
                      ? Expanded(
                          flex: 87,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AutoSizeText(
                                titleProject!,
                                minFontSize: 10,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(fontSize: 30),
                              ),
                            ),
                          ),
                        )
                      : Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        child: Icon(Icons.folder),
                        onTap: () async {
                          PickedFile? image;
                          if (!kIsWeb) {
                            image = await _picker.getImage(
                                source: ImageSource.gallery);
                          } else {
                            image = await _picker.getImage(
                                source: ImageSource.camera);
                          }
                          if (image != null) {
                            supportStore.updatePath(image);
                          }
                        }),
                  ),
                ]),
      height: image!.path == "" ? 40 : 300,
    );
  }
}
