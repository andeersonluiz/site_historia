import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:site_historia/Desktop/tile/podcastTile_desktop.dart';

class LatestPodcast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /**CONECTAR AO BD PARA CARREGAR ULTIMOS PODCAST DO SITE*/
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Ultimos Podcasts",
            style: GoogleFonts.roboto(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
                color: Theme.of(context).primaryColor),
          ),
        ),
        PodcastTile('Title Podcast 1', "Date: 00-00-00"),
        PodcastTile('Title Podcast 2', "Date: 00-00-00"),
        PodcastTile('Title Podcast 3', "Date: 00-00-00"),
      ],
    );
  }
}
