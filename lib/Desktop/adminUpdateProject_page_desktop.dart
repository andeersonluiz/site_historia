import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customCheckBox_component.dart';
import 'package:site_historia/Components/customHtmlEditor_component.dart';
import 'package:site_historia/Components/customTextFormField_component.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Components/customToast_component.dart';
import 'package:site_historia/Components/erroMsg_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Support/errorHander_support.dart';
import 'package:site_historia/firebase/project_firestore.dart';
import 'package:site_historia/firebase/teacher_firestore.dart';
import 'package:site_historia/model/project_model.dart';
import 'package:site_historia/model/teacher_model.dart';

class AdminUpdateProjectPageDesktop extends StatelessWidget {
  final Project project;
  AdminUpdateProjectPageDesktop(this.project);
  @override
  Widget build(BuildContext context) {
    final projectFirestore = Provider.of<ProjectFirestore>(context);
    final supportStore = Provider.of<SupportStore>(context);
    final teacherFirestore = Provider.of<TeacherFirestore>(context);
    final _picker = ImagePicker();
    final HtmlEditorController contentController = HtmlEditorController();

    return SingleChildScrollView(
        child: FutureBuilder(
      future: teacherFirestore.getTeachers(),
      builder: (ctx, snp) {
        if (snp.hasData) {
          List<Teacher> listTeachers = snp.data as List<Teacher>;
          supportStore.loadDataUpdate(project, listTeachers);

          return Container(
            width: 500,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: "Insira o titulo",
                  labelText: "Titulo",
                  initialValue: project.name,
                  onChanged: (text) {
                    supportStore.updateTitle(text);
                  },
                  onFieldSubmitted: (value) {
                    supportStore.updateTitle(value.toString());
                    supportStore.clearError(ErrorForm.Title);
                  },
                  onEditingComplete: () {
                    supportStore.clearError(ErrorForm.Title);
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          supportStore.pathImage!.path != ""
                              ? Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      supportStore.titleProject,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!,
                                    ),
                                  ),
                                )
                              : Container(),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                child: Icon(Icons.folder),
                                onTap: () async {
                                  PickedFile? image = await _picker.getImage(
                                      source: ImageSource.camera);
                                  supportStore.updatePath(image);
                                  supportStore.clearError(ErrorForm.Image);
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
                Observer(builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                        height: 400,
                        child: CustomHtmlEditor(
                          controller: contentController,
                          onChange: (value) {
                            if (value.toString() ==
                                supportStore.htmlContent!.toString()) {
                              supportStore.updateContent(value);
                            }
                          },
                          initialText: supportStore.htmlContent,
                        )),
                  );
                }),
                Observer(builder: (_) {
                  return supportStore.msgErrorContent == ""
                      ? Container()
                      : ErrorMsg(supportStore.msgErrorContent);
                }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(children: [
                        Center(
                            child: CustomText(
                                "Selecione os professores que participam do projeto",
                                style: Theme.of(context).textTheme.subtitle1)),
                        Observer(builder: (_) {
                          return supportStore.msgErrorTeacher == ""
                              ? Container()
                              : ErrorMsg(supportStore.msgErrorTeacher);
                        }),
                      ]),
                    ),
                    Expanded(
                      child: Column(children: [
                        Center(
                            child: CustomText(
                                "Escreva os alunos que participam do projeto",
                                style: Theme.of(context).textTheme.subtitle1)),
                        Observer(builder: (_) {
                          return supportStore.msgErrorParticipants == ""
                              ? Container()
                              : ErrorMsg(supportStore.msgErrorParticipants);
                        }),
                      ]),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Observer(
                            builder: (context) => ListView.builder(
                                itemCount: supportStore.teacherLocal.length,
                                shrinkWrap: true,
                                itemBuilder: (ctx, index) {
                                  return CustomCheckBox(
                                      title:
                                          supportStore.teacherLocal[index].name,
                                      value: supportStore
                                          .teacherLocal[index].checked,
                                      onChanged: (_) {
                                        supportStore.updateTeacherLocal(
                                            supportStore.teacherLocal[index],
                                            index);
                                      });
                                })),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(8.0),
                              child: CustomTextFormField(
                                  textInputType: TextInputType.number,
                                  hintText:
                                      "Digite o numero de participantes (Max. 10)",
                                  labelText: "Numero de participantes",
                                  initialValue:
                                      project.participants.length.toString(),
                                  onFieldSubmitted:
                                      supportStore.validateParticipant)),
                          Observer(builder: (_) {
                            return supportStore.msgErrorParticipantsSize == ""
                                ? Container()
                                : ErrorMsg(
                                    supportStore.msgErrorParticipantsSize);
                          }),
                          Observer(
                            builder: (context) => ListView.builder(
                              shrinkWrap: true,
                              itemCount: supportStore.participantsLocal.length,
                              itemBuilder: (ctx, index) {
                                return CustomTextFormField(
                                  textInputType: TextInputType.name,
                                  onChanged: (value) =>
                                      supportStore.updateParticipants(
                                    value,
                                    index,
                                  ),
                                  initialValue:
                                      supportStore.participantsLocal[index],
                                  hintText: "Nome Participante ${index + 1}",
                                  labelText: 'Participante  ${index + 1}',
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                CustomButton(
                  text: "Salvar Alterações",
                  onPressed: () async {
                    if (supportStore.validateProjectDesktop()) {
                      var result = await projectFirestore.updateProject(
                          project.id,
                          supportStore.titleProject,
                          supportStore.pathImage,
                          supportStore.htmlContent,
                          supportStore.getTeachers(),
                          supportStore.getParticipantsLocalFilled(),
                          projectFirestore.username);
                      if (result) {
                        CustomToast.showToast(
                            "Projeto cadastro com sucesso!!", Colors.green);
                      } else {
                        CustomToast.showToast(
                          "Não foi possivel cadastrar seu projeto, tente novamente mais tarde.",
                          Colors.red,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          );
        } else if (snp.hasError) {
          return ErrorLoad(
            color: Theme.of(context).primaryColor,
          );
        } else {
          return CustomLoading();
        }
      },
    ));
  }
}
