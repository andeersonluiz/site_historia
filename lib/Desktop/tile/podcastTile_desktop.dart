import 'package:flutter/material.dart';
import '../../model/notice_model.dart';

class PodcastTile extends StatelessWidget {
  final Notice podcast;
  PodcastTile(this.podcast);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.45,
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(podcast.imageHeader),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Podcast',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Theme.of(context).primaryColor)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      podcast.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                        podcast.datePost,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Theme.of(context).primaryColor),
                      )),
                ]),
          )
        ],
      ),
    );
  }
}
