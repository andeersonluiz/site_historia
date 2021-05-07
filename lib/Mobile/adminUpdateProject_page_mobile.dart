import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customCheckBox_component.dart';
import 'package:site_historia/Components/customHtmlEditor_component.dart';
import 'package:site_historia/Components/customTextFormField_component.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Components/erroMsg_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:site_historia/Store/teacher_store.dart';
import 'adminUpdateProjectParticipant_page_mobile.dart';

class AdminUpdateProjectPageMobile extends StatefulWidget {
  final Project project;
  AdminUpdateProjectPageMobile(this.project);

  @override
  _AdminUpdateProjectPageMobileState createState() =>
      _AdminUpdateProjectPageMobileState();
}

class _AdminUpdateProjectPageMobileState
    extends State<AdminUpdateProjectPageMobile> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final teacherStore = Provider.of<TeacherStore>(context);
    final supportStore = Provider.of<SupportStore>(context);
    /*CODE PBP*/
    supportStore.clearData();
    teacherStore.getTeachers();
    supportStore.loadInitialData(widget.project);
  }

  @override
  Widget build(BuildContext context) {
    final supportStore = Provider.of<SupportStore>(context);
    final teacherStore = Provider.of<TeacherStore>(context);
    final _picker = ImagePicker();
    final HtmlEditorController contentController = HtmlEditorController();

    return Observer(
      builder: (ctx) {
        teacherStore.listTeachers ?? teacherStore.getTeachers();
        switch (teacherStore.listTeachers!.status) {
          case FutureStatus.fulfilled:
            List<Teacher> listTeachers =
                teacherStore.listTeachers!.value as List<Teacher>;
            supportStore.createTeacherLocal(listTeachers, widget.project);
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    hintText: "Insira o titulo",
                    labelText: "Titulo",
                    maxCharacters: 30,
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
                      child: Row(children: [
                        supportStore.pathImage!.path != ""
                            ? Expanded(
                                flex: 95,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      supportStore.title,
                                      minFontSize: 10,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(fontSize: 30),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        Spacer(),
                        Expanded(
                          flex: 5,
                          child: InkWell(
                              child: Icon(Icons.folder),
                              onTap: () async {
                                PickedFile? image = await _picker.getImage(
                                    source: ImageSource.camera);
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
                  Center(
                    child: CustomText(
                        "Selecione os professores que participam do projeto",
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                  Observer(builder: (_) {
                    return supportStore.msgErrorTeacher == ""
                        ? Container()
                        : ErrorMsg(supportStore.msgErrorTeacher);
                  }),
                  Observer(
                      builder: (context) => ListView.builder(
                          itemCount: supportStore.teacherLocal.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return CustomCheckBox(
                                title: supportStore.teacherLocal[index].name,
                                value: supportStore.teacherLocal[index].checked,
                                onChanged: (_) {
                                  supportStore.updateTeacherLocal(
                                      supportStore.teacherLocal[index], index);
                                });
                          })),
                  SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                      text: "Próximo",
                      onPressed: () async {
                        if (supportStore.validateProjectMobileTab1()) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  AdminUpdateProjectParticipantPageMobile(
                                      widget.project.id)));
                        }
                      }),
                ],
              ),
            );
          case FutureStatus.rejected:
            return ErrorLoad(
              color: Theme.of(context).primaryColor,
            );
          case FutureStatus.pending:
            return CustomLoading();
        }
      },
    );
  }
}
