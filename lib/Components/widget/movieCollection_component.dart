/// Widget responsável por exibir o acervo de filmes na página de admin,
/// na seção de acervos.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library MovieCollectionWidget;

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customTextFormField_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Model/collection_item.dart';
import 'package:site_historia/Store/collection_store.dart';

/// O widget exibe todos os acervos de filmes criados e permite o usuário
/// adicionar ou remove-las.
class MovieCollectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final collectionStore = Provider.of<CollectionStore>(context);
    return Container(
      child: Column(children: [
        Observer(builder: (_) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: collectionStore.collection!.exams.length,
              itemBuilder: (ctx, index) {
                var controllerName = TextEditingController(
                    text: collectionStore.collection!.exams[index].name);
                var controllerUrl = TextEditingController(
                    text: collectionStore.collection!.exams[index].url);

                return Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                      hintText: 'Nome',
                      labelText: 'Nome',
                      controller: controllerName,
                      textInputType: TextInputType.name,
                      onChanged: (newName) {
                        collectionStore.updateRecommendationExamName(
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
                        collectionStore.updateRecommendationExamUrl(
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
                          if (collectionStore.collection!.exams[index].name !=
                                  "" &&
                              collectionStore.collection!.exams[index].url !=
                                  "") {
                            _showMaterialDialog(
                                context,
                                collectionStore.collection!.exams[index],
                                collectionStore,
                                index);
                          } else {
                            collectionStore.removeExam(
                                collectionStore.collection!.exams[index],
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
            collectionStore.addExam();
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
                      await collectionStore.removeExam(item, index);
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
