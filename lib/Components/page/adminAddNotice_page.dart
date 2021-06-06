/// Widget responsável por exibir a página de adição de professor (Admin).
///
/// {@category Component}
/// {@subCategory Page}
// ignore: library_names
library AdminAddNoticePage;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customDropdown_component.dart';
import 'package:site_historia/Components/widget/customHtmlEditor_component.dart';
import 'package:site_historia/Components/widget/customTextFormField_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/customToast_component.dart';
import 'package:site_historia/Components/widget/erroMsg_component.dart';
import 'package:site_historia/Components/widget/audio_component.dart';
import 'package:site_historia/Components/widget/image_component.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:velocity_x/velocity_x.dart';

///  A montagem do formulário é composto pelos widgets `CustomHtmlEditor()` que generaliza o widget de edição de texto,
///  `ImageWidget()` que generaliza a exibição e seleção da imagem da notícia e o `AudioWidget()` que
///  exibe a seleção de áudio. Por fim, valida os dados e caso retorno seja verdadeiro,
///  é inserido no banco de dados.
class AdminAddNoticePage extends StatefulWidget {
  @override
  _AdminAddNoticePageState createState() =>
      _AdminAddNoticePageState();
}

class _AdminAddNoticePageState extends State<AdminAddNoticePage> {
  NoticeStore? noticeStore;
  int? nextId;
  bool created = false;
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
    final HtmlEditorController contentController = HtmlEditorController();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                  contentController, nextId == null ? null : nextId.toString()),
              onBeforeCommand: supportStore.updateAfterContent,
              mediaUploadInterceptor: (file, type) async {
                nextId ??= await noticeStore!.getNextId();
                var url = await noticeStore!.convertBase64ToUrl(
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
                text: "Criar Notícia",
                loadingText: "Criando notícia...",
                isLoading: supportStore.isLoading!,
                onPressed: () async {
                  if (supportStore.validateNotice()) {
                    supportStore.setLoading(true);
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
                    supportStore.setLoading(false);
                    if (result) {
                      created = true;
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (!created && nextId != null) {
      noticeStore!.clearContent(nextId.toString());
    }
    super.dispose();
  }
}
