import 'package:flutter/material.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/Theme/ThemeConfig.dart';
import 'package:velocity_x/velocity_x.dart';

class Loading extends StatelessWidget {
  final bool redirect;
  Loading({this.redirect = false});
  @override
  Widget build(BuildContext context) {
    if(redirect){
      Future.delayed(Duration(seconds:2)).whenComplete(() => VxNavigator.of(context).push(Uri.parse(RouteNames.HOME)));
    }
    return Container(
        color: ThemeConfig.brown,
        child: Center(
            child: Image.asset(
          "assets/loading.gif",
          width: 150,
          height: 150,
        ) 
        ));
  }
}
