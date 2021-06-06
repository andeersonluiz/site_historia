/// Widget responsável controlar a exibição do menu vertical na página do Admin.
///
/// {@category Desktop}
/// {@subCategory Drawer}
// ignore: library_names
library VerticalAppBar;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBarMax_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBarMin_desktop.dart';
import 'package:site_historia/Store/support_store.dart';

/// Controla a exibição através da variável de controle `supportStore.verticalIsMax` se exibe
/// o widget `VerticalAppBarMaxDesktop()` ou o `VerticalAppBarMinDesktop()`.
class VerticalAppBar extends StatefulWidget {
  @override
  _VerticalAppBarState createState() => _VerticalAppBarState();
}

class _VerticalAppBarState extends State<VerticalAppBar> {
  double width = 300;
  IconData icon = Icons.arrow_back_ios_sharp;
  @override
  Widget build(BuildContext context) {
    SupportStore supportStore = Provider.of<SupportStore>(context);
    return Observer(builder: (_) {
      return Center(
        child: AnimatedContainer(
          width: supportStore.verticalIsMax ? 300 : 75,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).primaryColor,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
          child: Column(
            children: [
              supportStore.verticalIsMax
                  ? VerticalAppBarMaxDesktop()
                  : VerticalAppBarMinDesktop(),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(supportStore.verticalIsMax
                        ? Icons.arrow_back_ios_sharp
                        : Icons.arrow_forward_ios_sharp),
                    onPressed: () {
                      supportStore.changeVerticalBar();
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}
