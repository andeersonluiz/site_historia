import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PodcastTile extends StatelessWidget {
  final noticeText;
  final descriptionNotice;
  PodcastTile(this.noticeText, this.descriptionNotice);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.45,
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                      "data:image/png;base64,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"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Podcast',
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      noticeText,
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        descriptionNotice,
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color: Theme.of(context).primaryColor),
                      )),
                ]),
          )
        ],
      ),
    );
  }
}
