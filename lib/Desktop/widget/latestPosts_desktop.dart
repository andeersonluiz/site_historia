import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:site_historia/Desktop/tile/postTile_desktop.dart';

class LatestPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /**CONECTAR AO BD PARA CARREGAR ULTIMAS POSTAGENS DO SITE*/
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Ultimas Postagens",
            style: GoogleFonts.roboto(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
                color: Theme.of(context).primaryColor),
          ),
        ),
        PostTile('Title Notice 1', "Date: 00-00-00"),
        PostTile('Title Notice 2', "Date: 00-00-00"),
        PostTile('Title Notice 3', "Date: 00-00-00"),
      ],
    );
  }
}
