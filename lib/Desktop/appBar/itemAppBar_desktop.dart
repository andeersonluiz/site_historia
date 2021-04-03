import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ItemAppBar extends StatelessWidget {
  final String title;
  final Function function;

  ItemAppBar(this.title, this.function);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: InkWell(
          child: AutoSizeText(title,
              minFontSize: 10,
              maxFontSize: 40,
              style: TextStyle(fontWeight: FontWeight.bold)),
          onTap: () => function,
        ),
      ),
    );
  }
}
