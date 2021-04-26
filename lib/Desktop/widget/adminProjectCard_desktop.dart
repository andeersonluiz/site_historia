import 'package:flutter/material.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/model/project_model.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminProjectCard extends StatelessWidget {
  final Project project;
  final double sizeCard = 250;
  AdminProjectCard(this.project);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
          elevation: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          semanticContainer: true,
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => VxNavigator.of(context).push(Uri(
                      path: RouteNames.UPDATE_PROJECT,
                      queryParameters: {"id": project.id.toString()})),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Image.network(project.imageHeader,
                        fit: BoxFit.fill, height: sizeCard)),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: sizeCard,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Spacer(),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(project.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor)),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Autor: " + project.author,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor)),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Data do Post: " + project.datePost,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ])),
    );
  }
}
