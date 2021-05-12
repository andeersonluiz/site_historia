import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customDropdown_component.dart';
import 'package:site_historia/Components/customHtmlEditor_component.dart';
import 'package:site_historia/Components/customTextFormField_component.dart';
import 'package:site_historia/Components/customToast_component.dart';
import 'package:site_historia/Components/erroMsg_component.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminAddNoticePageDesktop extends StatefulWidget {
  @override
  _AdminAddNoticePageDesktopState createState() =>
      _AdminAddNoticePageDesktopState();
}

class _AdminAddNoticePageDesktopState extends State<AdminAddNoticePageDesktop> {
  NoticeStore? noticeStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    noticeStore = Provider.of<NoticeStore>(context);
    final supportStore = Provider.of<SupportStore>(context);
    /*CODE PBP*/
    supportStore.clearData();
  }

  @override
  Widget build(BuildContext context) {
    final supportStore = Provider.of<SupportStore>(context);
    final _picker = ImagePicker();
    final HtmlEditorController contentController = HtmlEditorController();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextFormField(
              hintText: "Insira o titulo da Noticia",
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
              hintText: "Insira o subtítulo da Noticia",
              labelText: "Subtítulo",
              maxCharacters: 50,
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
                      "Tag da noticia\n(visivel no site)",
                      textAlign: TextAlign.center,
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
                  ? Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText("Audio podcast",
                                style: Theme.of(context).textTheme.headline6)),
                        Observer(builder: (ctx) {
                          return Container(
                            color: Colors.white,
                            child: supportStore.audioFile!.name == null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                              child: Icon(Icons.folder),
                                              onTap: () async {
                                                FilePickerResult? result;

                                                result = await FilePicker
                                                    .platform
                                                    .pickFiles(
                                                  type: FileType.audio,
                                                );

                                                supportStore.updateAudio(
                                                    result!.files.first);
                                              }),
                                        ),
                                      ])
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                        Spacer(),
                                        CustomText(
                                            "Arquvio selecionado: ${supportStore.audioFile!.name.toString()}"),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                              child: Icon(Icons.folder),
                                              onTap: () async {
                                                FilePickerResult? result;
                                                if (!kIsWeb) {
                                                  result = await FilePicker
                                                      .platform
                                                      .pickFiles(
                                                    type: FileType.audio,
                                                  );
                                                } else {
                                                  result = await FilePicker
                                                      .platform
                                                      .pickFiles(
                                                    type: FileType.audio,
                                                  );
                                                }
                                                supportStore.updateAudio(
                                                    result!.files.first);
                                              }),
                                        ),
                                      ]),
                            height: 40,
                          );
                        }),
                      ],
                    )
                  : Container(),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText("Imagem titulo",
                    style: Theme.of(context).textTheme.headline6)),
            Observer(
              builder: (ctx) => Container(
                decoration: supportStore.pathImage!.path != ""
                    ? BoxDecoration(
                        image: DecorationImage(
                        image: NetworkImage(supportStore.pathImage!.path),
                        fit: BoxFit.fill,
                      ))
                    : BoxDecoration(color: Colors.grey),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
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

                          supportStore.updatePath(image);
                        }),
                  ),
                ]),
                height: supportStore.pathImage!.path == "" ? 40 : 300,
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
              onChange: supportStore.updateContent,
              initialText: supportStore.htmlContent,
            ),
            Observer(builder: (_) {
              return supportStore.msgErrorContent == ""
                  ? Container()
                  : ErrorMsg(supportStore.msgErrorContent);
            }),
            CustomButton(
              text: "Criar Notícia",
              onPressed: () async {
                if (supportStore.validateNotice()) {
                  var result = await noticeStore!.addNotice(
                      supportStore.title,
                      supportStore.subtitle,
                      supportStore.type,
                      supportStore.tag,
                      supportStore.audioFile!,
                      supportStore.pathImage,
                      supportStore.isTopHeader,
                      supportStore.htmlContent,
                      GlobalsVariables.username);
                  if (result) {
                    CustomToast.showToast(
                        "Notícia cadastrada com sucesso!!", Colors.green);
                    VxNavigator.of(context)
                        .push(Uri.parse(RouteNames.ADMIN_NOTICES));
                  } else {
                    CustomToast.showToast(
                      "Não foi possivel cadastrar sua notícia, tente novamente mais tarde.",
                      Colors.red,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
