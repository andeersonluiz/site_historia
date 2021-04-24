import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class CustomHtmlEditor extends StatelessWidget {
  final HtmlEditorController contentController = HtmlEditorController();
  final dynamic Function(String?)? onChange;
  CustomHtmlEditor({this.onChange});

  @override
  Widget build(BuildContext context) {
    return HtmlEditor(
      controller: contentController,
      hint: "Escreva o texto aqui...",
      options: HtmlEditorOptions(
        height: 400,
        showBottomToolbar: false,
        shouldEnsureVisible: true,
      ),
      callbacks: Callbacks(
          onChange: onChange,
          onFocus: () => FocusScope.of(context).requestFocus(new FocusNode()),
          onImageUploadError:
              (FileUpload? file, String? base64Str, UploadError error) {
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
        }, onFileUploadError:
            (FileUpload? file, String? base64Str, UploadError error) {
          print(describeEnum(error));
          print(base64Str ?? "");
          if (file != null) {
            print(file.name);
            print(file.size);
            print(file.type);
          }
        }),
      ],
    );
  }
}
