import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class CustomHtmlEditor extends StatelessWidget {
  final dynamic Function(String?)? onChange;
  final String? initialText;
  final HtmlEditorController controller;

  CustomHtmlEditor(
      {required this.onChange, this.initialText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Theme(
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
          initialText: initialText,
        ),
        otherOptions: OtherOptions(
          height: 400,
        ),
        callbacks: Callbacks(
          onChange: onChange,
        ),
        htmlToolbarOptions: HtmlToolbarOptions(
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
              StyleButtons(),
              FontSettingButtons(fontSizeUnit: false),
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
              ),
            ]),
      ),
    );
  }
}
