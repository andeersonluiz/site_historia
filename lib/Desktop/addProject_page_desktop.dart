import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Support/errorHander_support.dart';
import 'package:site_historia/firebase/project_firestore.dart';
import 'package:site_historia/firebase/teacher_firestore.dart';
import 'package:site_historia/model/teacher_model.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectFirestore = Provider.of<ProjectFirestore>(context);
    final supportStore = Provider.of<SupportStore>(context);
    final teacherFirestore = Provider.of<TeacherFirestore>(context);
    final HtmlEditorController contentController = HtmlEditorController();
    final _picker = ImagePicker();

    return SingleChildScrollView(
        child: FutureBuilder(
      future: teacherFirestore.getTeachers(),
      builder: (ctx, snp) {
        if (snp.hasData) {
          List<Teacher> listTeachers = snp.data as List<Teacher>;
          supportStore.createTeacherLocal(listTeachers);
          return Container(
            width: 500,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (text) {
                      supportStore.updateTitle(text);
                    },
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintText: "Insira o titulo",
                      labelText: "Titulo",
                      border: OutlineInputBorder(),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                Observer(builder: (_) {
                  return supportStore.msgErrorTitle == ""
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            supportStore.msgErrorTitle,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.red),
                          ),
                        );
                }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Imagem titulo",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
                Observer(
                  builder: (ctx) => Container(
                    decoration: supportStore.pathImage != ""
                        ? BoxDecoration(
                            image: DecorationImage(
                            image: AssetImage("assets/test.jpg"),
                            fit: BoxFit.fill,
                          ))
                        : BoxDecoration(color: Colors.grey),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          supportStore.pathImage != ""
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
                          IconButton(
                              icon: Icon(Icons.folder),
                              onPressed: () async {
                                PickedFile? image = await _picker.getImage(
                                    source: ImageSource.camera);
                                supportStore.updatePath(image!.path);
                              }),
                        ]),
                    height: supportStore.pathImage == "" ? 40 : 300,
                  ),
                ),
                Observer(builder: (_) {
                  return supportStore.msgErrorImage == ""
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            supportStore.msgErrorImage,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.red),
                          ),
                        );
                }),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  height: 400,
                  child: HtmlEditor(
                    controller: contentController,
                    hint: "Escreva o texto aqui...",
                    options: HtmlEditorOptions(
                      height: 400,
                      showBottomToolbar: false,
                      shouldEnsureVisible: true,
                    ),
                    callbacks: Callbacks(
                        onChange: supportStore.onChangedHtml,
                        onFocus: () => FocusScope.of(context)
                            .requestFocus(new FocusNode()),
                        onImageUploadError: (FileUpload? file,
                            String? base64Str, UploadError error) {
                          if (file != null) {
                            print(file.name);
                            print(file.size);
                            print(file.type);
                          }
                        }),
                    plugins: [
                      SummernoteEmoji(),
                      AdditionalTextTags(),
                      SummernoteCaseConverter(),
                      SummernoteListStyles(),
                      SummernoteRTL(),
                      SummernoteCodewrapper(),
                      SummernoteFile(onFileLinkInsert: (String link) {
                        print(link);
                      }, onFileUploadError: (FileUpload? file,
                          String? base64Str, UploadError error) {
                        print(describeEnum(error));
                        print(base64Str ?? "");
                        if (file != null) {
                          print(file.name);
                          print(file.size);
                          print(file.type);
                        }
                      }),
                    ],
                  ),
                ),
                Observer(builder: (_) {
                  return supportStore.msgErrorContent == ""
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            supportStore.msgErrorContent,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.red),
                          ),
                        );
                }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(children: [
                        Center(
                          child: Text(
                            "Selecione os professores que participam do projeto",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Observer(builder: (_) {
                          return supportStore.msgErrorTeacher == ""
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    supportStore.msgErrorTeacher,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: Colors.red),
                                  ),
                                );
                        }),
                      ]),
                    ),
                    Expanded(
                      child: Column(children: [
                        Center(
                          child: Text(
                            "Escreva os alunos que participam do projeto",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Observer(builder: (_) {
                          return supportStore.msgErrorParticipants == ""
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    supportStore.msgErrorParticipants,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: Colors.red),
                                  ),
                                );
                        }),
                      ]),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Observer(
                          builder: (context) => ListView.builder(
                              itemCount: supportStore.teacherLocal.length,
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                return Row(children: [
                                  Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor:
                                            Theme.of(context).primaryColor),
                                    child: Checkbox(
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        value: supportStore
                                            .teacherLocal[index].checked,
                                        onChanged: (_) {
                                          supportStore
                                              .updateCheckedTeacherLocal(
                                                  supportStore
                                                      .teacherLocal[index],
                                                  index);
                                        }),
                                  ),
                                  Text(
                                    supportStore.teacherLocal[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                ]);
                              })),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                                keyboardType: TextInputType.number,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText:
                                        "Digite o numero de participantes (Max. 10)"),
                                onSubmitted: (value) {
                                  if (value.isNumber()) {
                                    int num = int.parse(value);
                                    if (num > 10) {
                                      supportStore.generateMsgError(
                                          ErrorForm.ParticipantSize,
                                          "Só pode adicionar até 10 participantes.");
                                    } else {
                                      supportStore
                                          .addParticipants(int.parse(value));
                                      supportStore.clearError(
                                          ErrorForm.ParticipantSize);
                                    }
                                  } else {
                                    supportStore.generateMsgError(
                                        ErrorForm.ParticipantSize,
                                        "Digite um numero.");
                                  }
                                }),
                          ),
                          Observer(builder: (_) {
                            return supportStore.msgErrorParticipantsSize == ""
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      supportStore.msgErrorParticipantsSize,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(color: Colors.red),
                                    ),
                                  );
                          }),
                          Observer(
                            builder: (context) => ListView.builder(
                              shrinkWrap: true,
                              itemCount: supportStore.participantsLocal.length,
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                    onChanged: (value) => supportStore
                                        .changeValueParticipant(index, value),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText:
                                          "Nome Participante ${index + 1}",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      String err = "";
                      if (supportStore.titleProject == "") {
                        supportStore.generateMsgError(
                            ErrorForm.Title, "O titulo não pode ser vazio.");
                        err += "err1";
                      } else if (supportStore.titleProject.length > 40) {
                        supportStore.generateMsgError(ErrorForm.Title,
                            "O titulo não ter mais de 40 caracteres.");
                        err += "err2";
                      } else {
                        supportStore.clearError(ErrorForm.Title);
                      }
                      if (supportStore.pathImage == "") {
                        supportStore.generateMsgError(
                            ErrorForm.Image, "Selecione uma imagem titulo.");
                        err += "err3";
                      } else {
                        supportStore.clearError(ErrorForm.Image);
                      }

                      if (supportStore.htmlContent == "") {
                        supportStore.generateMsgError(ErrorForm.Content,
                            "O conteudo não pode estar vazio.");
                        err += "err4";
                      } else {
                        supportStore.clearError(ErrorForm.Content);
                      }
                      if (supportStore.getTeachers().length == 0) {
                        supportStore.generateMsgError(ErrorForm.Teacher,
                            "Você deve selecionar pelo menos um professor.");
                        err += "err5";
                      } else {
                        supportStore.clearError(ErrorForm.Teacher);
                      }
                      if (supportStore.getParticipants().length == 0) {
                        supportStore.generateMsgError(ErrorForm.Participant,
                            "Digite pelo menos um participante.");
                        err += "err6";
                      } else {
                        supportStore.clearError(ErrorForm.Participant);
                      }
                      if (err == "") {
                        var result = await projectFirestore.addProject(
                            supportStore.titleProject,
                            supportStore.pathImage,
                            supportStore.htmlContent,
                            supportStore.getTeachers(),
                            supportStore.getParticipants(),
                            projectFirestore.username);
                        if (result) {
                          Fluttertoast.showToast(
                              msg: "Projeto cadastro com sucesso!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  "Não foi possivel cadastrar seu projeto, tente novamente mais tarde.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Text("CRIAR PROJETO",
                        style: Theme.of(context).textTheme.subtitle1!)),
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
