import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/erroMsg_component.dart';
import 'package:site_historia/Store/support_store.dart';

class AudioWidget extends StatelessWidget {
  final title;
  AudioWidget({required this.title});
  @override
  Widget build(BuildContext context) {
    final supportStore = Provider.of<SupportStore>(context);

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(title,
                style: Theme.of(context).textTheme.headline6)),
        Observer(builder: (ctx) {
          return Container(
            color: Colors.white,
            child: supportStore.audioFile!.name == null
                ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          child: Icon(Icons.folder),
                          onTap: () async {
                            FilePickerResult? result;

                            result = await FilePicker.platform.pickFiles(
                              type: FileType.audio,
                            );
                            if (result != null) {
                              supportStore.updateAudio(result.files.first);
                            }
                          }),
                    ),
                  ])
                : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Expanded(
                      child: CustomText(
                        supportStore.audioFile!.name != ""
                            ? "Arquivo selecionado: ${supportStore.audioFile!.name.toString()}"
                            : "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          child: Icon(Icons.folder),
                          onTap: () async {
                            FilePickerResult? result;
                            if (!kIsWeb) {
                              result = await FilePicker.platform.pickFiles(
                                type: FileType.audio,
                              );
                            } else {
                              result = await FilePicker.platform.pickFiles(
                                type: FileType.audio,
                              );
                            }
                            if (result != null) {
                              supportStore.updateAudio(result.files.first);
                            }
                          }),
                    ),
                  ]),
            height: 40,
          );
        }),
        Observer(builder: (_) {
          return supportStore.msgErrorAudio == ""
              ? Container()
              : ErrorMsg(supportStore.msgErrorAudio);
        }),
      ],
    );
  }
}
