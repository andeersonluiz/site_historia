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
          PostTile('Title Notice 1'),
          PostTile('Title Notice 2'),
          PostTile('Title Notice 3'),
          PostTile('Title Notice 4'),
          PostTile('Title Notice 5'),
        ],
      ),
    );
  }
}
