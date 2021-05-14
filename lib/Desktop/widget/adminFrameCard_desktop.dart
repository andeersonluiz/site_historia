import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customImage_component.dart';
import 'package:site_historia/Components/customText_component.dart';
import 'package:site_historia/Model/frame_model.dart';
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminFrameCard extends StatelessWidget {
  final int index;
  final double sizeCard = 200;
  AdminFrameCard(this.index);
  @override
  Widget build(BuildContext context) {
    FrameStore frameStore = Provider.of<FrameStore>(context);

    return Container(
        padding: EdgeInsets.all(8.0),
        child: Card(
            elevation: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            semanticContainer: true,
            child: Column(
              children: [
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () => VxNavigator.of(context).push(Uri(
                            path: RouteNames.UPDATE_FRAME,
                            queryParameters: {
                              "id": frameStore.listFrames!.value[index].id
                                  .toString()
                            })),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () => _showMaterialDialog(context,
                            frameStore.listFrames!.value[index], frameStore),
                      ),
                    ],
                  ),
                ),
                Row(children: [
                  Expanded(
                      flex: 3,
                      child: CustomImage(
                          image:
                              frameStore.listFrames!.value[index].imageHeader,
                          height: sizeCard)),
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
                                child: Text(
                                    frameStore.listFrames!.value[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .primaryColor)),
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "Autor: " +
                                          frameStore
                                              .listFrames!.value[index].author,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "Data do Post: " +
                                          frameStore.listFrames!.value[index]
                                              .datePost,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                ]),
              ],
            )));
  }

  _showMaterialDialog(
      BuildContext context, Frame frame, FrameStore frameStore) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new CustomText(
                "Confirmar Exclusão",
                style: Theme.of(context).textTheme.headline5,
              ),
              content: new CustomText(
                "Tem certeza que deseja excluir o quadro ${frame.title}?",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              actions: <Widget>[
                CustomButton(
                    text: "Sim",
                    onPressed: () async {
                      await frameStore.deleteFrame(frame.id);
                      frameStore.getFrames();
                      Navigator.of(context).pop();
                    }),
                CustomButton(
                  text: "Não",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
