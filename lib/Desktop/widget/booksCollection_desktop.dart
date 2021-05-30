import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customTextFormField_component.dart';
import 'package:site_historia/Components/customText_component.dart';
import 'package:site_historia/Model/collection_item.dart';
import 'package:site_historia/Store/collection_store.dart';

class BookCollectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final collectionStore = Provider.of<CollectionStore>(context);
    return Container(
      child: Column(children: [
        Observer(builder: (_) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: collectionStore.collection!.books.length,
              itemBuilder: (ctx, index) {
                var controllerName = TextEditingController(
                    text: collectionStore.collection!.books[index].name);

                return Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                      hintText: 'Nome',
                      labelText: 'Nome',
                      controller: controllerName,
                      textInputType: TextInputType.name,
                      onChanged: (newName) {
                        collectionStore.updateRecommendationBookName(
                            index, newName);
                      },
                      validator: (text) {
                        if (text == "") {
                          return "Preencha o campo.";
                        }
                      },
                    )),
                    Expanded(
                        child: Container(
                      color: Colors.grey,
                      child: collectionStore.collection!.books[index].urlName ==
                              ""
                          ? Row(
                              children: [
                                collectionStore
                                        .collection!.books[index].isLoading
                                    ? CustomText("Carregando...")
                                    : Container(),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.folder),
                                  onPressed: () async {
                                    FilePickerResult? result;

                                    result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.any,
                                    );
                                    collectionStore.setLoadingBook(index, true);
                                    if (result != null) {
                                      await collectionStore
                                          .updateRecommendationBookUrl(
                                              index, result.files.first);
                                    }
                                    collectionStore.setLoadingBook(
                                        index, false);
                                  },
                                )
                              ],
                            )
                          : Row(
                              children: [
                                collectionStore
                                        .collection!.books[index].isLoading
                                    ? CustomText("Carregando...")
                                    : Expanded(
                                        child: CustomText(
                                            collectionStore.collection!
                                                .books[index].urlName,
                                            maxLines: 1)),
                                IconButton(
                                  icon: Icon(Icons.folder),
                                  onPressed: () async {
                                    FilePickerResult? result;

                                    result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.any,
                                    );
                                    collectionStore.setLoadingBook(index, true);
                                    if (result != null) {
                                      await collectionStore
                                          .updateRecommendationBookUrl(
                                              index, result.files.first);
                                    }
                                    collectionStore.setLoadingBook(
                                        index, false);
                                  },
                                ),
                              ],
                            ),
                    )),
                    IconButton(
                        onPressed: () {
                          if (collectionStore.collection!.books[index].name !=
                                  "" &&
                              collectionStore.collection!.books[index].url !=
                                  "") {
                            _showMaterialDialog(
                                context,
                                collectionStore.collection!.books[index],
                                collectionStore,
                                index);
                          } else {
                            collectionStore.removeBook(
                                collectionStore.collection!.books[index],
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
          text: "Adicionar novo livro",
          expandButton: true,
          onPressed: () {
            collectionStore.addBook();
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
                    isLoading: collectionStore.isLoading,
                    loadingText: "Deletando...",
                    onPressed: () async {
                      collectionStore.setLoading(true);
                      await collectionStore.removeBook(item, index);
                      await collectionStore
                          .saveCollection(collectionStore.collection!);
                      collectionStore.setLoading(false);
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
