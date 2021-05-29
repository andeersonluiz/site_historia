import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Components/customToast_component.dart';
import 'package:site_historia/Desktop/widget/blogRecommendation_desktop.dart';
import 'package:site_historia/Desktop/widget/otherRecommendation_desktop.dart';
import 'package:site_historia/Desktop/widget/podcastRecommendation_desktop.dart';
import 'package:site_historia/Desktop/widget/youtubeRecommendation_desktop.dart';
import 'package:site_historia/Model/recommendation_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/recommendation_store.dart';
import 'package:site_historia/firebase/recommendation_firestore.dart';

class AdminRecommendationPageDesktop extends StatefulWidget {
  @override
  _AdminRecommendationPageDesktopState createState() =>
      _AdminRecommendationPageDesktopState();
}

class _AdminRecommendationPageDesktopState
    extends State<AdminRecommendationPageDesktop> {
  RecommendationStore? recommendationStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    recommendationStore = Provider.of<RecommendationStore>(context);

    /*CODE PBP*/
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return FutureBuilder(
      future: RecommendationFirestore.getRecommendations(),
      builder: (ctx, snp) {
        if (snp.hasData) {
          Recommendation recommendation = snp.data as Recommendation;
          recommendationStore!.recommendation = recommendation;
          return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    CustomText(
                      "Youtube",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    YoutubeRecommendationWidget(),
                    CustomText(
                      "Blogs",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    BlogRecommendationWidget(),
                    CustomText(
                      "Podcasts",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    PodcastRecommendationWidget(),
                    CustomText(
                      "Outros",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    OtherRecommendationWidget(),
                    CustomButton(
                        text: "Salvar alterações",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            recommendationStore!.saveRecommendation(
                                recommendationStore!.recommendation!);
                            CustomToast.showToast(
                                "Recomendações atualizadas!!", Colors.green);
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
