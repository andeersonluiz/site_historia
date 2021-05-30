import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customHtmlEditor_component.dart';
import 'package:site_historia/Components/widget/customTextFormField_component.dart';
import 'package:site_historia/Components/widget/customToast_component.dart';
import 'package:site_historia/Components/widget/erroMsg_component.dart';
import 'package:site_historia/Components/widget/audio_desktop_component.dart';
import 'package:site_historia/Components/widget/image_component.dart';
import 'package:site_historia/Desktop/widget/video_desktop.dart';
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminAddFramePageDesktop extends StatefulWidget {
  @override
  _AdminAddFramePageDesktopState createState() =>
      _AdminAddFramePageDesktopState();
}

class _AdminAddFramePageDesktopState extends State<AdminAddFramePageDesktop> {
  int? nextId;
  FrameStore? frameStore;
  bool created = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final supportStore = Provider.of<SupportStore>(context);
    frameStore = Provider.of<FrameStore>(context);
    /*CODE PBP*/
    supportStore.clearData();
  }

  @override
  Widget build(BuildContext context) {
    final supportStore = Provider.of<SupportStore>(context);
    final HtmlEditorController contentController = HtmlEditorController();
    final frameStore = Provider.of<FrameStore>(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextFormField(
              hintText: "Insira o titulo do Quadro",
              labelText: "Titulo",
              maxCharacters: GlobalsVariables.maxCharactersTitle,
              initialValue: supportStore.title,
              onChanged: (text) {
                supportStore.updateTitle(text);
              },
              textInputType: TextInputType.name,
            ),
            Observer(builder: (_) {
              return supportStore.msgErrorTitle == ""
                  ? Container()
                  : ErrorMsg(supportStore.msgErrorTitle);
            }),
            CustomTextFormField(
              hintText: "Insira o subtítulo do Quadro",
              labelText: "Subtítulo",
              maxCharacters: GlobalsVariables.maxCharactersSubTitle,
              initialValue: supportStore.subtitle,
              onChanged: (text) {
                supportStore.updateSubTitle(text);
              },
              textInputType: TextInputType.name,
            ),
            Observer(builder: (_) {
              return supportStore.msgErrorSubTitle == ""
                  ? Container()
                  : ErrorMsg(supportStore.msgErrorSubTitle);
            }),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText("Imagem titulo",
                    style: Theme.of(context).textTheme.headline6)),
            Observer(
              builder: (ctx) => ImageWidget(
                image: supportStore.pathImage,
              ),
            ),
            Observer(builder: (_) {
              return supportStore.msgErrorImage == ""
                  ? Container()
                  : ErrorMsg(supportStore.msgErrorImage);
            }),
            CustomTextFormField(
              hintText: 'Digite a legenda da imagem (opcional)',
              textInputType: TextInputType.name,
              onChanged: (value) {
                supportStore.updateSubtitleImage(value);
              },
              initialValue: supportStore.subtitleImage,
            ),
            AudioWidget(
              title: "Audio (Opcional)",
            ),
            VideoWidgetDesktop(
              title: "Video (Opcional)",
            ),
            CustomHtmlEditor(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              controller: contentController,
              onChange: (text) => supportStore.updateContent(frameStore, text,
                  contentController, nextId == null ? null : nextId.toString()),
              onBeforeCommand: supportStore.updateAfterContent,
              mediaUploadInterceptor: (file, type) async {
                nextId ??= await frameStore.getNextId();
                var url = await frameStore.convertBase64ToUrl(
                    file.name!, file.bytes!, nextId.toString());
                contentController.insertNetworkImage(url, filename: file.name!);
                return false;
              },
              initialText: supportStore.htmlContent,
            ),
            Observer(builder: (_) {
              return supportStore.msgErrorContent == ""
                  ? Container()
                  : ErrorMsg(supportStore.msgErrorContent);
            }),
            Observer(
              builder: (_) => CustomButton(
                text: "Criar Quadro",
                loadingText: "Criando Quadro...",
                isLoading: supportStore.isLoading!,
                onPressed: () async {
                  if (supportStore.validateFrame()) {
                    supportStore.setLoading(true);
                    var result = await frameStore.addFrame(
                        supportStore.title,
                        supportStore.subtitle,
                        supportStore.pathImage,
                        supportStore.subtitleImage!,
                        supportStore.htmlContent!,
                        supportStore.audioFile!,
                        supportStore.videoFile!.name != null
                            ? supportStore.videoFile!
                            : supportStore.urlPopUp != ""
                                ? supportStore.urlPopUp
                                : "",
                        GlobalsVariables.username);
                    supportStore.setLoading(false);
                    if (result) {
                      created = true;
                      CustomToast.showToast(
                          "Quadro cadastrada com sucesso!!", Colors.green);
                      VxNavigator.of(context)
                          .push(Uri.parse(RouteNames.ADMIN_FRAMES));
                    } else {
                      CustomToast.showToast(
                        "Não foi possivel cadastrar seu quadro, tente novamente mais tarde.",
                        Colors.red,
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (!created && nextId != null) {
      frameStore!.clearContent(nextId.toString());
    }
    super.dispose();
  }
}
