import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customTextFormField_component.dart';
import 'package:site_historia/Components/customText_component.dart';
import 'package:site_historia/Model/recommendationItem_model.dart';
import 'package:site_historia/Store/recommendation_store.dart';

class YoutubeRecommendationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recommendationStore = Provider.of<RecommendationStore>(context);
    return Container(
      child: Column(children: [
        Observer(builder: (_) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: recommendationStore.recommendation!.youtubeList.length,
              itemBuilder: (ctx, index) {
                var controllerName = TextEditingController(
                    text: recommendationStore
                        .recommendation!.youtubeList[index].name);
                var controllerUrl = TextEditingController(
                    text: recommendationStore
                        .recommendation!.youtubeList[index].url);

                return Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                      hintText: 'Nome',
                      labelText: 'Nome',
                      textInputType: TextInputType.name,
                      controller: controllerName,
                      onChanged: (newName) {
                        recommendationStore.updateRecommendationYoutubeName(
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
                        recommendationStore.updateRecommendationYoutubeUrl(
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
                                      .youtubeList[index].name !=
                                  "" &&
                              recommendationStore
                                      .recommendation!.youtubeList[index].url !=
                                  "") {
                            _showMaterialDialog(
                                context,
                                recommendationStore
                                    .recommendation!.youtubeList[index],
                                recommendationStore);
                          } else {
                            recommendationStore.removeYoutube(
                                recommendationStore
                                    .recommendation!.youtubeList[index]);
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
          text: "Adicionar recomendação de youtube",
          expandButton: true,
          onPressed: () {
            recommendationStore.addYoutube();
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
                      recommendationStore.removeYoutube(item);
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
