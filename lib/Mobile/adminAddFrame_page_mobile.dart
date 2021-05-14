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
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminAddFramePageMobile extends StatefulWidget {
  @override
  _AdminAddFramePageMobileState createState() =>
      _AdminAddFramePageMobileState();
}

class _AdminAddFramePageMobileState extends State<AdminAddFramePageMobile> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final supportStore = Provider.of<SupportStore>(context);
    /*CODE PBP*/
    supportStore.clearData();
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
              maxCharacters: 30,
              initialValue: supportStore.title,
              onChanged: (text) {
                supportStore.updateTitle(text);
              },
              textInputAction: TextInputAction.next,
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
              maxCharacters: 100,
              initialValue: supportStore.subtitle,
              onChanged: (text) {
                supportStore.updateSubTitle(text);
              },
              textInputAction: TextInputAction.next,
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
            AudioWidget(
              title: "Audio (Opcional)",
            ),
            VideoWidgetMobile(
              title: "Video (Opcional)",
            ),
            CustomHtmlEditor(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              controller: contentController,
              onChange: supportStore.updateContent,
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
                        supportStore.htmlContent,
                        supportStore.audioFile!,
                        supportStore.videoFile!.name != null
                            ? supportStore.videoFile!
                            : supportStore.urlPopUp != ""
                                ? supportStore.urlPopUp
                                : "",
                        GlobalsVariables.username);
                    supportStore.setLoading(false);
                    if (result) {
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
}
