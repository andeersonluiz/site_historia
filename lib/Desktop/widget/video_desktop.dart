/// Widget responsável por exibir o widget de seleção de vídeo (Admin - desktop).
///
/// {@category Desktop}
/// {@subCategory Widget}
// ignore: library_names
library VideoWidgetMobile;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customTextFormField_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/erroMsg_component.dart';
import 'package:site_historia/Store/support_store.dart';

///  O widget é composto por um método que exibe um pop up que pede para o usuário inserir
///  um link ou arquivo de vídeo, os dados são validados com apenas um podendo ser escolhido.
class VideoWidgetDesktop extends StatelessWidget {
  final title;
  VideoWidgetDesktop({required this.title});
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
            color: Colors.redAccent,
            child: (supportStore.videoFile!.name == null &&
                    supportStore.urlPopUp == "")
                ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          child: Icon(Icons.folder),
                          onTap: () =>
                              _showMaterialDialog(context, supportStore)),
                    ),
                  ])
                : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Expanded(
                      child: CustomText(
                        (supportStore.videoFile!.name != null &&
                                supportStore.videoFile!.name != "")
                            ? "Video selecionado: ${supportStore.videoFile!.name.toString()}"
                            : supportStore.urlPopUp != ""
                                ? "Url selecionada: ${supportStore.urlPopUp}"
                                : "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          child: Icon(Icons.folder),
                          onTap: () =>
                              _showMaterialDialog(context, supportStore)),
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

  _showMaterialDialog(BuildContext context, SupportStore supportStore) {
    final controllerUrl = TextEditingController(text: supportStore.urlPopUp);

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new CustomText(
                "Carregar video",
                style: Theme.of(context).textTheme.headline5,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              content: Container(
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomText("Url:"),
                          PointerInterceptor(
                            child: Container(
                              width: 400,
                              child: CustomTextFormField(
                                  onChanged: (value) {
                                    supportStore.updateUrlPopUp(value);
                                  },
                                  controller: controllerUrl,
                                  hintText: "digite a url",
                                  textInputType: TextInputType.name),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              supportStore.updateUrlPopUp("");
                              controllerUrl.clear();
                            },
                          )
                        ],
                      ),
                      CustomText("OU"),
                      Row(
                        children: [
                          PointerInterceptor(
                            child: CustomButton(
                              text: "Carregar Arquivo",
                              onPressed: () async {
                                FilePickerResult? result;
                                if (!kIsWeb) {
                                  result = await FilePicker.platform.pickFiles(
                                    type: FileType.video,
                                  );
                                } else {
                                  result = await FilePicker.platform.pickFiles(
                                    type: FileType.video,
                                  );
                                }
                                if (result != null) {
                                  supportStore.updateVideo(result.files.first);
                                }
                              },
                            ),
                          ),
                          Observer(
                            builder: (_) => Container(
                              width: 200,
                              height: 30,
                              color: Colors.grey,
                              child: Center(
                                child: CustomText(
                                  supportStore.videoFile!.name == null
                                      ? ""
                                      : supportStore.videoFile!.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              supportStore.updateVideo(PlatformFile());
                            },
                          )
                        ],
                      ),
                      Observer(
                        builder: (_) => supportStore.msgErrorPopUp == ""
                            ? Container()
                            : ErrorMsg(supportStore.msgErrorPopUp),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                PointerInterceptor(
                  child: CustomButton(
                      paddingButton: EdgeInsets.zero,
                      text: "Salvar",
                      onPressed: () async {
                        if (supportStore.validatePopUp() == "") {
                          Navigator.of(context).pop();
                        }
                      }),
                ),
                PointerInterceptor(
                  child: CustomButton(
                      paddingButton: EdgeInsets.zero,
                      text: "Fechar",
                      onPressed: () async {
                        supportStore.updateVideo(PlatformFile());
                        supportStore.updateUrlPopUp("");
                        controllerUrl.clear();
                        Navigator.of(context).pop();
                      }),
                ),
              ],
            ));
  }
}
