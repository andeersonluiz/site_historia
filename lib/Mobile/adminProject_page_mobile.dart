import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Mobile/widget/adminProjectCard_mobile.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/firebase/project_firestore.dart';
import 'package:site_historia/model/project_model.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminProjectPageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectFirestore = Provider.of<ProjectFirestore>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
          future: projectFirestore.getProjects(),
          builder: (ctx, snp) {
            if (snp.hasError) {
              return ErrorLoad(
                color: Theme.of(context).primaryColor,
              );
            } else if (snp.hasData) {
              List<Project> listProjects = snp.data as List<Project>;
              return ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.add_circle_rounded),
                    title: CustomText("Adicionar Projeto",
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () => VxNavigator.of(context)
                        .push(Uri.parse(RouteNames.ADD_PROJECT)),
                  ),
                  for (var project in listProjects)
                    AdminProjectCardMobile(project),
                ],
              );
            } else {
              return CustomLoading();
            }
          }),
    );
  }
}
