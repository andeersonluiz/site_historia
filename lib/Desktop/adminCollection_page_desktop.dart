import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Components/customToast_component.dart';
import 'package:site_historia/Desktop/widget/articleCollection_desktop.dart';
import 'package:site_historia/Desktop/widget/booksCollection_desktop.dart';
import 'package:site_historia/Desktop/widget/movieCollection_desktop.dart';
import 'package:site_historia/Desktop/widget/othersCollection_desktop.dart';
import 'package:site_historia/Model/collection_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/collection_store.dart';
import 'package:site_historia/firebase/collection_firestore.dart';

class AdminCollectionPageDesktop extends StatefulWidget {
  @override
  _AdminCollectionPageDesktopState createState() =>
      _AdminCollectionPageDesktopState();
}

class _AdminCollectionPageDesktopState
    extends State<AdminCollectionPageDesktop> {
  CollectionStore? collectionStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    collectionStore = Provider.of<CollectionStore>(context);

    /*CODE PBP*/
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return FutureBuilder(
      future: CollectionFirestore.getCollections(),
      builder: (ctx, snp) {
        if (snp.hasData) {
          Collection collection = snp.data as Collection;
          collectionStore!.collection = collection;
          return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    CustomText(
                      "Filmes",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    MovieCollectionWidget(),
                    CustomText(
                      "Livros",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    BookCollectionWidget(),
                    CustomText(
                      "Artigos",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    ArticleCollectionWidget(),
                    CustomText(
                      "Outros",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    OthersCollectionWidget(),
                    CustomButton(
                        text: "Salvar alterações",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            collectionStore!
                                .saveCollection(collectionStore!.collection!);
                            CustomToast.showToast(
                                "Acervo atualizado!!", Colors.green);
                          }
                        })
                  ]),
                )),
          );
        } else if (snp.hasError) {
          return ErrorLoad(color: Theme.of(context).primaryColor);
        } else {
          return CustomLoading();
        }
      },
    );
  }
}
