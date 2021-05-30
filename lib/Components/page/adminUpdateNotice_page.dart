import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customDropdown_component.dart';
import 'package:site_historia/Components/widget/customHtmlEditor_component.dart';
import 'package:site_historia/Components/widget/customTextFormField_component.dart';
import 'package:site_historia/Components/widget/customToast_component.dart';
import 'package:site_historia/Components/widget/erroMsg_component.dart';
import 'package:site_historia/Components/widget/audio_desktop_component.dart';
import 'package:site_historia/Components/widget/image_component.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:velocity_x/velocity_x.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class AdminUpdateNoticePage extends StatefulWidget {
  final Notice notice;
  AdminUpdateNoticePage(this.notice);
  @override
  _AdminUpdateNoticePageState createState() =>
      _AdminUpdateNoticePageState();
}

class _AdminUpdateNoticePageState
    extends State<AdminUpdateNoticePage> {
  NoticeStore? noticeStore;
  final DateTime timeOpen = DateTime.now();
  bool updated = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    noticeStore = Provider.of<NoticeStore>(context);
    final supportStore = Provider.of<SupportStore>(context);
    /*CODE PBP*/
    supportStore.clearData();
    supportStore.loadInitialDataNotice(widget.notice);
    html.window.onBeforeUnload.listen((event) async {
      /*Listen reload (not delete image when reload)*/
    });
  }

  @override
  Widget build(BuildContext context) {
    final supportStore = Provider.of<SupportStore>(context);
    final HtmlEditorController contentController = HtmlEditorController();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          CustomTextFormField(
            hintText: "Insira o titulo da Noticia",
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
            hintText: "Insira o subtítulo da Noticia",
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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: CustomText(
                    "Tipo de noticia",
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: CustomText(
                    "Tag da noticia (visivel no site)",
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Observer(
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomDropdown(
                      onChanged: (newType) {
                        supportStore.updateType(newType.toString());
                      },
                      value: supportStore.type,
                      items: GlobalsVariables.types,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Observer(
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomDropdown(
                      onChanged: (newTag) {
                        supportStore.updateTag(newTag.toString());
                      },
                      value: supportStore.tag,
                      items: GlobalsVariables.tags,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Observer(
            builder: (_) => supportStore.type == "Podcast"
                ? AudioWidget(
                    title: "Audio Podcast",
                  )
                : Container(),
          ),
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
          CustomHtmlEditor(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            controller: contentController,
            onChange: (text) => supportStore.updateContent(noticeStore, text,
                contentController, widget.notice.id.toString()),
            onBeforeCommand: supportStore.updateAfterContent,
            initialText: supportStore.htmlContent,
            mediaUploadInterceptor: (file, type) async {
              var url = await noticeStore!.convertBase64ToUrl(
                  file.name!, file.bytes!, widget.notice.id.toString());
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
              loadingText: "Salvango...",
              isLoading: supportStore.isLoading!,
              onPressed: () async {
                if (supportStore.validateNotice()) {
                  supportStore.setLoading(true);
                  var result = await noticeStore!.updateNotice(
                      widget.notice,
                      supportStore.title,
                      supportStore.subtitle,
                      supportStore.type,
                      supportStore.tag,
                      supportStore.audioFile!,
                      supportStore.pathImage,
                      supportStore.isTopHeader,
                      supportStore.htmlContent,
                      widget.notice.views,
                      GlobalsVariables.username);
                  supportStore.setLoading(false);
                  if (result) {
                    updated = true;
                    CustomToast.showToast(
                        "Notícia alterada com sucesso!!", Colors.green);
                    VxNavigator.of(context)
                        .push(Uri.parse(RouteNames.ADMIN_NOTICES));
                  } else {
                    CustomToast.showToast(
                      "Não foi possivel alterar sua notícia, tente novamente mais tarde.",
                      Colors.red,
                    );
                  }
                }
              },
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    if (!updated) {
      noticeStore!.clearContent(widget.notice.id.toString(), time: timeOpen);
    }
    super.dispose();
  }
}
