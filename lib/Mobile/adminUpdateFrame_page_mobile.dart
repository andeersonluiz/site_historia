import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customHtmlEditor_component.dart';
import 'package:site_historia/Components/customTextFormField_component.dart';
import 'package:site_historia/Components/customToast_component.dart';
import 'package:site_historia/Components/erroMsg_component.dart';
import 'package:site_historia/Desktop/widget/audio_desktop.dart';
import 'package:site_historia/Desktop/widget/image_desktop.dart';
import 'package:site_historia/Mobile/widget/video_mobile.dart';
import 'package:site_historia/Model/frame_model.dart';
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminUpdateFramePageMobile extends StatefulWidget {
  final Frame frame;
  AdminUpdateFramePageMobile(this.frame);
  @override
  _AdminUpdateFramePageMobileState createState() =>
      _AdminUpdateFramePageMobileState();
}

class _AdminUpdateFramePageMobileState
    extends State<AdminUpdateFramePageMobile> {
  final DateTime timeOpen = DateTime.now();
  bool updated = false;
  FrameStore? frameStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final supportStore = Provider.of<SupportStore>(context);
    frameStore = Provider.of<FrameStore>(context);
    /*CODE PBP*/
    supportStore.clearData();
    supportStore.loadInitialDataFrame(widget.frame);
  }

  @override
  Widget build(BuildContext context) {
    final supportStore = Provider.of<SupportStore>(context);
    final frameStore = Provider.of<FrameStore>(context);
    final HtmlEditorController contentController = HtmlEditorController();
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
            CustomTextFormField(
              hintText: 'Digite a legenda da imagem (opcional)',
              textInputType: TextInputType.name,
              onChanged: (value) {
                supportStore.updateSubtitleImage(value);
              },
              initialValue: supportStore.subtitleImage,
              maxCharacters: GlobalsVariables.maxCharactersSubTitle,
            ),
            Observer(builder: (_) {
              return supportStore.msgErrorImage == ""
                  ? Container()
                  : ErrorMsg(supportStore.msgErrorImage);
            }),
            AudioWidget(
              title: "Audio (Opcional)",
            ),
            VideoWidgetMobile(
              title: "Video (Opcional)",
            ),
            CustomHtmlEditor(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              controller: contentController,
              onChange: (text) => supportStore.updateContent(frameStore, text,
                  contentController, widget.frame.id.toString()),
              onBeforeCommand: supportStore.updateAfterContent,
              initialText: supportStore.htmlContent,
              mediaUploadInterceptor: (file, type) async {
                var url = await frameStore.convertBase64ToUrl(
                    file.name!, file.bytes!, widget.frame.id.toString());
                contentController.insertNetworkImage(url, filename: file.name!);
                return false;
              },
            ),
            Observer(builder: (_) {
              return supportStore.msgErrorContent == ""
                  ? Container()
                  : ErrorMsg(supportStore.msgErrorContent);
            }),
            Observer(
              builder: (_) => CustomButton(
                text: "Salvar alterações",
                loadingText: "Salvando...",
                isLoading: supportStore.isLoading!,
                onPressed: () async {
                  if (supportStore.validateFrame()) {
                    supportStore.setLoading(true);
                    var result = await frameStore.updateFrame(
                        widget.frame,
                        supportStore.title,
                        supportStore.subtitle,
                        supportStore.pathImage,
                        supportStore.subtitleImage!,
                        supportStore.htmlContent,
                        supportStore.audioFile!,
                        supportStore.videoFile!.name != null
                            ? supportStore.videoFile!
                            : supportStore.urlPopUp != ""
                                ? supportStore.urlPopUp
                                : "",
                        widget.frame.views,
                        GlobalsVariables.username);
                    supportStore.setLoading(false);
                    if (result) {
                      updated = true;
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
    if (!updated) {
      frameStore!.clearContent(widget.frame.id.toString(), time: timeOpen);
    }
    super.dispose();
  }
}
