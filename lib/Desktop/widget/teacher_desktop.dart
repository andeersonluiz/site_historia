/// Widget responsável por exibir o widget de seleção de vídeo (Admin - desktop).
///
/// {@category Desktop}
/// {@subCategory Widget}
// ignore: library_names
library TeacherWidgetDesktop;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customCheckBox_component.dart';
import 'package:site_historia/Store/support_store.dart';

/// O widget generaliza a exibição da seleção de professores.
class TeacherWidgetDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final supportStore = Provider.of<SupportStore>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Observer(
          builder: (context) => ListView.builder(
              itemCount: supportStore.teacherLocal.length,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return CustomCheckBox(
                    title: supportStore.teacherLocal[index].name,
                    value: supportStore.teacherLocal[index].checked,
                    onChanged: (_) {
                      supportStore.updateTeacherLocal(
                          supportStore.teacherLocal[index], index);
                    });
              })),
    );
  }
}
