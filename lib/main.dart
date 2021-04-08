import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Screens/home_screen.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Theme/ThemeConfig.dart';
//Paleta Cores
//#572a1e (marrom escuro)
//#e07d5e (barro)
//#f3cfb8 (rosa claro)
//#ffffff (branco)
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers:[
      Provider<SupportStore>(create: (_)=>SupportStore()),
    ],
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Site Historia',
      theme: ThemeConfig.theme,
      home:Home(),
    );
  }
}

