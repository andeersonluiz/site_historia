import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:velocity_x/velocity_x.dart';

class VerticalItem extends StatelessWidget {
  final String title;
  final String path;
  final IconData icon;
  final bool isMini;
  VerticalItem(
    this.title,
    this.path,
    this.icon,
    {this.isMini=false}
  );
  @override
  Widget build(BuildContext context) {
    return HoverButton(
        hoverColor: Theme.of(context).hoverColor,
        shape: BeveledRectangleBorder(),
        padding: EdgeInsets.all(8),
        hoverPadding: EdgeInsets.all(0),
        
        child: Center(
          child: Tooltip(
            message: title,
            height: 42,
            decoration: BoxDecoration(color: Theme.of(context).iconTheme.color,
            borderRadius: BorderRadius.circular(8.0)
            ),
            textStyle: Theme.of(context).textTheme.caption!.copyWith(color:Theme.of(context).primaryColor),
            child: isMini==false?ListTile(
                leading: Icon(icon,color: Theme.of(context).iconTheme.color),
                title: AutoSizeText(
                  title,
                  minFontSize: 5,
                  maxFontSize: 16,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.subtitle1,   
              ),
            ):Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon,color: Theme.of(context).iconTheme.color,size: 30,),
            ),
          ),
        ),  
        onpressed: () => VxNavigator.of(context).replace(Uri.parse(path)));
  }
}
