/// Widget responsável por exibir a página de professor.
///
/// {@category Component}
/// {@subCategory Page}
// ignore: library_names
library TeacherInfoPage;

import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Mobile/footer/footer_mobile.dart';
import 'package:site_historia/Model/teacher_model.dart';

/// Widget que recebe um objeto `Teacher`. Onde são organizadas as informações do professor.
class TeacherInfoPage extends StatelessWidget {
  final Teacher teacher;
  TeacherInfoPage(this.teacher);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
    maxHeight: double.infinity,
    ),
    child: IntrinsicHeight(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:24.0,right: 32.0,bottom:4.0,top: 16.0),
            child: CustomText(teacher.name,textAlign: TextAlign.start,style: Theme.of(context).textTheme.headline4,),
          ),
          Divider(height: 1,thickness: 1.0,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left:32.0,right: 32.0,top: 20.0,bottom: 20.0),
              child: SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text:teacher.description==""?"Não há descrição disponível para este professor.":teacher.description
                    ,style:Theme.of(context).textTheme.subtitle1!.copyWith(color: Theme.of(context).primaryColor)
                    ),
                    TextSpan(
                        text:"\n\nProjeto(s): "
                        ,style:Theme.of(context).textTheme.subtitle1!.copyWith(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                        text:"${teacher.projects.map((e) => e.name).toList().join(", ")}."
                        ,style:Theme.of(context).textTheme.subtitle1!.copyWith(color: Theme.of(context).primaryColor)
                    ),
                  ]
                )
              ),
            ),
          ),

          MediaQuery.of(context).size.width > 600
              ? Expanded(child: FooterDesktop())
              : FooterMobile(),
        ],
      ),
    ));
  }
}
