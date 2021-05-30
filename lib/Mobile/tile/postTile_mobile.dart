import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Support/globals_variables.dart';

import '../../Model/notice_model.dart';

class PostTileMobile extends StatelessWidget {
  final Notice notice;
  final double widthPercentage;
  PostTileMobile(this.notice, this.widthPercentage);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width * widthPercentage,
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 4,
                child: CustomImage(
                  height: 150,
                  image: notice.thumb,
                  circularRadius: 8.0,
                  padding: EdgeInsets.zero,
                )),
            Expanded(
              flex: 6,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: GlobalsVariables.colorByTag[notice.tag],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          notice.tag,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        notice.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          notice.datePost,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Theme.of(context).primaryColor),
                        )),
                  ]),
            )
          ],
        ));
  }
}
