import 'package:flutter/material.dart';
import 'package:site_historia/Widgets/postTile_widget.dart';

class ListPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PosteTile('Title Notice 1'),
          PosteTile('Title Notice 2'),
          PosteTile('Title Notice 3'),
          PosteTile('Title Notice 4'),
          PosteTile('Title Notice 5'),
        ],
      ),
    );
  }
}
