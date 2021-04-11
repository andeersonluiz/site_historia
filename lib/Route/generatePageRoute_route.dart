import 'package:flutter/cupertino.dart';

class GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  GeneratePageRoute(this.widget, this.routeName)
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (ctx, animation, secAnimation) => widget,
          transitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (ctx, animation, secAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
}
