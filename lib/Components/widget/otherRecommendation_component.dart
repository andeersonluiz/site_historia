/// Widget responsável por exibir as recomendações de outros na página de admin,
/// na seção de recomendações.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library OtherRecommendationWidget;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customTextFormField_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Model/recommendationItem_model.dart';
import 'package:site_historia/Store/recommendation_store.dart';

/// O widget exibe todos as recomendações de outros criadas e permite o usuário
/// adicionar ou remove-las.
class OtherRecommendationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recommendationStore = Provider.of<RecommendationStore>(context);
    return Container(
      child: Column(children: [
        Observer(builder: (_) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: recommendationStore.recommendation!.othersList.length,
              itemBuilder: (ctx, index) {
                var controllerName = TextEditingController(
                    text: recommendationStore
                        .recommendation!.othersList[index].name);
                var controllerUrl = TextEditingController(
                    text: recommendationStore
                        .recommendation!.othersList[index].url);

                return Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                      hintText: 'Nome',
                      labelText: 'Nome',
                      controller: controllerName,
                      textInputType: TextInputType.name,
                      onChanged: (newName) {
                        recommendationStore.updateRecommendationOtherName(
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
                        recommendationStore.updateRecommendationOtherUrl(
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
                          if (recommendationStore
                                      .recommendation!.othersList[index].name !=
                                  "" &&
                              recommendationStore
                                      .recommendation!.othersList[index].url !=
                                  "") {
                            _showMaterialDialog(
                                context,
                                recommendationStore
                                    .recommendation!.othersList[index],
                                recommendationStore);
                          } else {
                            recommendationStore.removeOther(recommendationStore
                                .recommendation!.othersList[index]);
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
          text: "Adicionar outra recomendação",
          expandButton: true,
          onPressed: () {
            recommendationStore.addOther();
          },
        ),
      ]),
    );
  }

  _showMaterialDialog(BuildContext context, RecommendationItem item,
      RecommendationStore recommendationStore) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new CustomText(
                "Confirmar Exclusão",
                style: Theme.of(context).textTheme.headline5,
              ),
              content: new CustomText(
                "Tem certeza que deseja excluir a referência ${item.name} com url ${item.url}?",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              actions: <Widget>[
                CustomButton(
                    text: "Sim",
                    onPressed: () async {
                      await recommendationStore.removeOther(item);
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
