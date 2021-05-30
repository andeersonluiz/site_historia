import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customTextFormField_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Model/collection_item.dart';
import 'package:site_historia/Store/collection_store.dart';

class MovieCollectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final collectionStore = Provider.of<CollectionStore>(context);
    return Container(
      child: Column(children: [
        Observer(builder: (_) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: collectionStore.collection!.movies.length,
              itemBuilder: (ctx, index) {
                var controllerName = TextEditingController(
                    text: collectionStore.collection!.movies[index].name);
                var controllerUrl = TextEditingController(
                    text: collectionStore.collection!.movies[index].url);

                return Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                      hintText: 'Nome',
                      labelText: 'Nome',
                      controller: controllerName,
                      textInputType: TextInputType.name,
                      onChanged: (newName) {
                        collectionStore.updateRecommendationMovieName(
                            index, newName);
                      },
                      validator: (text) {
                        if (text == "") {
                          return "Preencha o campo.";
                        }
                      },
                    )),
                    Expanded(
                        child: CustomTextFormField(
                      hintText: 'Url',
                      labelText: 'Url',
                      controller: controllerUrl,
                      textInputType: TextInputType.url,
                      onChanged: (newUrl) {
                        collectionStore.updateRecommendationMovieUrl(
                            index, newUrl);
                      },
                      validator: (text) {
                        if (text == "") {
                          return "Preencha o campo.";
                        }
                      },
                    )),
                    IconButton(
                        onPressed: () {
                          if (collectionStore.collection!.movies[index].name !=
                                  "" &&
                              collectionStore.collection!.movies[index].url !=
                                  "") {
                            _showMaterialDialog(
                                context,
                                collectionStore.collection!.movies[index],
                                collectionStore,
                                index);
                          } else {
                            collectionStore.removeMovie(
                                collectionStore.collection!.movies[index],
                                index);
                          }
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.red,
                        ))
                  ],
                );
              });
        }),
        CustomButton(
          text: "Adicionar novo filme",
          expandButton: true,
          onPressed: () {
            collectionStore.addMovie();
          },
        ),
      ]),
    );
  }

  _showMaterialDialog(BuildContext context, CollectionItem item,
      CollectionStore collectionStore, int index) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new CustomText(
                "Confirmar Exclusão",
                style: Theme.of(context).textTheme.headline5,
              ),
              content: new CustomText(
                "Tem certeza que deseja excluir o filme ${item.name} (A exclusão não pode ser desfeita)?",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              actions: <Widget>[
                CustomButton(
                    text: "Sim",
                    onPressed: () async {
                      await collectionStore.removeMovie(item, index);
                      await collectionStore
                          .saveCollection(collectionStore.collection!);
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
