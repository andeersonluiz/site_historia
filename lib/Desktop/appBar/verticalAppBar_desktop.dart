import 'package:flutter/material.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBarMax_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBarMin_desktop.dart';


class VerticalAppBar extends StatefulWidget {

  @override
  _VerticalAppBarState createState() => _VerticalAppBarState();
}

class _VerticalAppBarState extends State<VerticalAppBar> {
  double width=300;
  IconData icon= Icons.arrow_back_ios_sharp;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedContainer(
          width: width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).primaryColor,
          duration: Duration(milliseconds:500),
          curve: Curves.ease,
          child: Column(children: [
            icon==Icons.arrow_back_ios_sharp?VerticalAppBarMax():VerticalAppBarMin(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(icon: Icon(icon), onPressed: (){
                setState((){if(icon==Icons.arrow_back_ios_sharp){
                  width=75;
                  icon=Icons.arrow_forward_ios_sharp;
                }else{
                  width=300;
                  icon=Icons.arrow_back_ios_sharp;
                }});
                
              }),
            )
          ],),
        ),
      
    );
  }
}