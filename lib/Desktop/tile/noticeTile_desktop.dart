import 'package:flutter/material.dart';
import 'package:site_historia/Components/customImage_component.dart';
import 'package:site_historia/Components/customText_component.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:velocity_x/velocity_x.dart';

class NoticeTile extends StatelessWidget {
  final Notice notice;
  NoticeTile(this.notice);

  @override
  Widget build(BuildContext context) {
    final _onTap = () {
      return VxNavigator.of(context).push(Uri(
          path: RouteNames.NOTICES,
          queryParameters: {"id": notice.id.toString()}));
    };
    final datePost = notice.datePost.split(" ");
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
                onTap: _onTap,
                child: CustomImage(
                  height: 200,
                  image: notice.thumb,
                )),
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 18.0,
                  ),
                  child: InkWell(
                      onTap: _onTap,
                      splashColor: Colors.transparent,
                      child: CustomText(notice.title,
                          style: Theme.of(context).textTheme.headline5)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: _onTap,
                      splashColor: Colors.transparent,
                      child: CustomText(
                        notice.subtitle,
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 18.0,
                  ),
                  child: CustomText(
                    "Publicado dia ${datePost[0]} ás ${datePost[1]}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
