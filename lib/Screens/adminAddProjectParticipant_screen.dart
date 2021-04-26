import 'package:flutter/material.dart';
import 'package:site_historia/Mobile/adminAddProjectParticipants_page_mobile.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';

class AdminAddProjectParticipantScreen extends StatefulWidget {
  @override
  _AdminAddProjectParticipantScreenState createState() =>
      _AdminAddProjectParticipantScreenState();
}

class _AdminAddProjectParticipantScreenState
    extends State<AdminAddProjectParticipantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminNavigatorDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Adicionar Projeto"),
      ),
      body: AdminAddProjectParticipantPageMobile(),
    );
  }
}
