import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Center(
              child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor))),
    );
  }
}
