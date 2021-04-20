import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/firebase/project_firestore.dart';

class AddProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectFirestore = Provider.of<ProjectFirestore>(context);
    TextEditingController titleController = TextEditingController();
    final _keyForm = GlobalKey<FormState>();
    final HtmlEditorController contentController = HtmlEditorController();

    return Container(
      width: 500,
      child: Form(
        key: _keyForm,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Insira o titulo",
                labelText: "Titulo",
                labelStyle: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),),
             HtmlEditor(
                  controller: contentController,
                  hint: "Your text here...",
                  //initialText: "<p>text content initial, if any</p>",
                  options:
                      HtmlEditorOptions(height: 450, shouldEnsureVisible: true),
                  callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
                    print("html before change is $currentHtml");
                  }, onChange: (String? changed) {
                    print("content changed to $changed");
                  }, onChangeCodeview: (String? changed) {
                    print("code changed to $changed");
                  }, onDialogShown: () {
                    print("dialog shown");
                  }, onEnter: () {
                    print("enter/return pressed");
                  }, onFocus: () {
                    print("editor focused");
                  }, onBlur: () {
                    print("editor unfocused");
                  }, onBlurCodeview: () {
                    print("codeview either focused or unfocused");
                  }, onInit: () {
                    print("init");
                  },
                      //this is commented because it overrides the default Summernote handlers
                      /*onImageLinkInsert: (String? url) {
                      print(url ?? "unknown url");
                    },
                    onImageUpload: (FileUpload file) async {
                      print(file.name);
                      print(file.size);
                      print(file.type);
                      print(file.base64);
                    },*/
                      onImageUploadError: (FileUpload? file, String? base64Str,
                          UploadError error) {
                    print(describeEnum(error));
                    print(base64Str ?? "");
                    if (file != null) {
                      print(file.name);
                      print(file.size);
                      print(file.type);
                    }
                  }, onKeyDown: (int? keyCode) {
                    print("$keyCode key downed");
                  }, onKeyUp: (int? keyCode) {
                    print("$keyCode key released");
                  }, onMouseDown: () {
                    print("mouse downed");
                  }, onMouseUp: () {
                    print("mouse released");
                  }, onPaste: () {
                    print("pasted into editor");
                  }, onScroll: () {
                    print("editor scrolled");
                  }),
                  plugins: [
                    SummernoteEmoji(),
                    AdditionalTextTags(),
                    SummernoteCaseConverter(),
                    SummernoteListStyles(),
                    SummernoteRTL(),
                    SummernoteAtMention(
                        getSuggestionsMobile: (String value) {
                          List<String> mentions = ['test1', 'test2', 'test3'];
                          return mentions
                              .where((element) => element.contains(value))
                              .toList();
                        },
                        mentionsWeb: ['test1', 'test2', 'test3'],
                        onSelect: (String value) {
                          print(value);
                        }),
                    SummernoteCodewrapper(),
                    SummernoteFile(
                        //this is commented because it overrides the default SummernoteFile handlers
                        /*onFileUpload: (FileUpload file) {
                        print(file.name);
                        print(file.size);
                        print(file.type);
                        print(file.base64);
                      },*/
                        onFileLinkInsert: (String link) {
                      print(link);
                    }, onFileUploadError: (FileUpload? file, String? base64Str,
                            UploadError error) {
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
            
          ],
        ),
      ),
    );
  }
}
