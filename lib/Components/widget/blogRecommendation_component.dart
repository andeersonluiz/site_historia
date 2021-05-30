import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customTextFormField_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Model/recommendationItem_model.dart';
import 'package:site_historia/Store/recommendation_store.dart';

class BlogRecommendationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recommendationStore = Provider.of<RecommendationStore>(context);
    return Container(
      child: Column(children: [
        Observer(builder: (_) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: recommendationStore.recommendation!.blogList.length,
              itemBuilder: (ctx, index) {
                final controllerName = TextEditingController(
                    text: recommendationStore
                        .recommendation!.blogList[index].name);
                final controllerUrl = TextEditingController(
                    text: recommendationStore
                        .recommendation!.blogList[index].url);
                return Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                      hintText: 'Nome',
                      labelText: 'Nome',
                      controller: controllerName,
                      textInputType: TextInputType.name,
                      onChanged: (newName) {
                        recommendationStore.updateRecommendationBlogName(
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
                        recommendationStore.updateRecommendationBlogUrl(
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
                                      .recommendation!.blogList[index].name !=
                                  "" &&
                              recommendationStore
                                      .recommendation!.blogList[index].url !=
                                  "") {
                            _showMaterialDialog(
                                context,
                                recommendationStore
                                    .recommendation!.blogList[index],
                                recommendationStore);
                          } else {
                            recommendationStore.removeBlog(recommendationStore
                                .recommendation!.blogList[index]);
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
          text: "Adicionar recomendação de blog",
          expandButton: true,
          onPressed: () {
            recommendationStore.addBlog();
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
                      recommendationStore.removeBlog(item);
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
