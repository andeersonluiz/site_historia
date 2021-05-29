import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customTextFormField_component.dart';
import 'package:site_historia/Components/customText_component.dart';
import 'package:site_historia/Model/recommendationItem_model.dart';
import 'package:site_historia/Store/recommendation_store.dart';

class PodcastRecommendationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recommendationStore = Provider.of<RecommendationStore>(context);
    return Container(
      child: Column(children: [
        Observer(builder: (_) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: recommendationStore.recommendation!.podcastList.length,
              itemBuilder: (ctx, index) {
                var controllerName = TextEditingController(
                    text: recommendationStore
                        .recommendation!.podcastList[index].name);
                var controllerUrl = TextEditingController(
                    text: recommendationStore
                        .recommendation!.podcastList[index].url);

                return Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                      hintText: 'Nome',
                      labelText: 'Nome',
                      controller: controllerName,
                      textInputType: TextInputType.name,
                      onChanged: (newName) {
                        recommendationStore.updateRecommendationPodcastName(
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
                        recommendationStore.updateRecommendationPodcastUrl(
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
                          if (recommendationStore.recommendation!
                                      .podcastList[index].name !=
                                  "" &&
                              recommendationStore
                                      .recommendation!.podcastList[index].url !=
                                  "") {
                            _showMaterialDialog(
                                context,
                                recommendationStore
                                    .recommendation!.podcastList[index],
                                recommendationStore);
                          } else {
                            recommendationStore.removePodcast(
                                recommendationStore
                                    .recommendation!.podcastList[index]);
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
          text: "Adicionar recomendação de podcast",
          expandButton: true,
          onPressed: () {
            recommendationStore.addPodcast();
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
                      recommendationStore.removePodcast(item);
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
