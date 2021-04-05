import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostTile extends StatelessWidget {
  final noticeText;
  final descriptionNotice;
  PostTile(this.noticeText, this.descriptionNotice);

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
                      "data:image/jpeg;base64,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"),
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
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Study',
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
