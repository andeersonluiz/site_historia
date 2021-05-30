import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customCheckBox_component.dart';
import 'package:site_historia/Store/support_store.dart';

class ProjectWidget extends StatelessWidget {
  final _crossAxisCount;
  ProjectWidget(this._crossAxisCount);
  final _crossAxisSpacing = 8.0;
  final cellHeight = 60;
  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _width =
        (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
            _crossAxisCount;
    final _aspectRatio = _width / cellHeight;

    final supportStore = Provider.of<SupportStore>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Observer(
          builder: (context) => GridView.builder(
              itemCount: supportStore.projectLocal.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount,
                crossAxisSpacing: _crossAxisSpacing,
                childAspectRatio: _aspectRatio,
              ),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return CustomCheckBox(
                    title: supportStore.projectLocal[index].name,
                    value: supportStore.projectLocal[index].checked,
                    onChanged: (_) {
                      supportStore.updateProjectLocal(
                          supportStore.projectLocal[index], index);
                    });
              })),
    );
  }
}
