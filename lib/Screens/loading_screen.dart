import 'package:flutter/material.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:site_historia/Theme/themeConfig.dart';
import 'package:velocity_x/velocity_x.dart';

class Loading extends StatelessWidget {
  final bool redirect;
  final String to;
  Loading({this.redirect = false,this.to=RouteNames.HOME});
  @override
  Widget build(BuildContext context) {
    if(redirect){
      Future.delayed(Duration(seconds:2)).whenComplete(() => VxNavigator.of(context).push(Uri.parse(to)));
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
