import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class CustomHtmlEditor extends StatelessWidget {
  final dynamic Function(String?)? onChange;
  final Function(String?)? onBeforeCommand;
  final String? initialText;
  final HtmlEditorController controller;
  final dynamic Function()? onInit;
  final EdgeInsets padding;
  final height;
  final FutureOr<bool> Function(PlatformFile, InsertFileType)
      mediaUploadInterceptor;
  CustomHtmlEditor({
    required this.onChange,
    this.initialText,
    required this.controller,
    required this.onBeforeCommand,
    this.onInit,
    this.padding = EdgeInsets.zero,
    this.height = 400,
    required this.mediaUploadInterceptor,
  });

  @override
  Widget build(BuildContext context) {
    ///NÃO ESQUECER DE ADIICIONAR convertBase64ToUrl E  removeFilename PARA OS OUTROS STORES

    return Container(
      height: height,
      child: Theme(
        data: ThemeData(
            primaryColor: Colors.red,
            selectedRowColor: Colors.red,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Theme.of(context).primaryColor,
                  displayColor: Theme.of(context).primaryColor,
                  decorationColor: Theme.of(context).primaryColor,
                )),
        child: HtmlEditor(
          controller: controller,
          htmlEditorOptions: HtmlEditorOptions(
            hint: "Escreva o texto aqui...",
            initialText: initialText!.replaceAll("video", "iframe"),
          ),
          otherOptions: OtherOptions(
            height: height,
          ),
          callbacks: Callbacks(
            onChange: onChange,
            onBeforeCommand: onBeforeCommand,
          ),
          htmlToolbarOptions: HtmlToolbarOptions(
              mediaUploadInterceptor: mediaUploadInterceptor,
              buttonFocusColor: Theme.of(context).primaryColor,
              buttonColor: Theme.of(context).primaryColor,
              buttonBorderColor: Colors.black,
              buttonFillColor: Theme.of(context).backgroundColor,
              buttonSelectedColor: Theme.of(context).primaryColor,
              dropdownFocusColor: Theme.of(context).primaryColor,
              textStyle: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Theme.of(context).primaryColor),
              toolbarType: ToolbarType.nativeGrid,
              defaultToolbarButtons: [
                FontSettingButtons(fontName: false, fontSizeUnit: false),
                FontButtons(
                    clearAll: false, superscript: false, subscript: false),
                ParagraphButtons(
                    increaseIndent: false,
                    decreaseIndent: false,
                    textDirection: false,
                    lineHeight: false,
                    caseConverter: false),
                InsertButtons(
                  otherFile: false,
                  video: false,
                  audio: false,
                ),
              ]),
        ),
      ),
    );
  }
}
