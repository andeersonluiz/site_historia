import 'package:flutter/material.dart';

class AuthorInfo extends StatelessWidget {
  final String author;
  final String datePost;
  AuthorInfo({required this.author, required this.datePost});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
          child: Text(
            "Autor: $author",
            style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).primaryColor,
                fontStyle: FontStyle.italic),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
          child: Text(
            "Data publicação: $datePost",
            style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).primaryColor,
                fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
}
