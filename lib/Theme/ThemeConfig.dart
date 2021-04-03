import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//Paleta Cores

//#572a1e (marrom escuro)
//#f3cfb8 (rosa claro)

//#ffffff (branco)
//#e07d5e (barro)

class ThemeConfig {
  static Color brown = Color.fromRGBO(87, 42, 30, 1);
  static Color textColor = Color.fromRGBO(232, 223, 220, 1);
  static Color white = Colors.white;
  static Color brownLight = Color.fromRGBO(245, 230, 225, 0.5);

  static ThemeData theme = ThemeData(
    backgroundColor: brownLight,
    primaryColor: brown,
    accentColor: brownLight,
    scaffoldBackgroundColor: brownLight,
    unselectedWidgetColor: brownLight,
    iconTheme: IconThemeData(
      color: textColor,
    ),
    appBarTheme: AppBarTheme(backgroundColor: brown),
    textTheme: TextTheme(
      headline1: GoogleFonts.roboto(
          fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
      headline2: GoogleFonts.roboto(
          fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
      headline3: GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
      headline4: GoogleFonts.roboto(
          fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headline5: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
      headline6: GoogleFonts.roboto(
          fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      subtitle1: GoogleFonts.roboto(
          fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
      subtitle2: GoogleFonts.roboto(
          fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyText1: GoogleFonts.roboto(
          fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyText2: GoogleFonts.roboto(
          fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      button: GoogleFonts.roboto(
          fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      caption: GoogleFonts.roboto(
          fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      overline: GoogleFonts.roboto(
          fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    ).apply(
      bodyColor: textColor,
      displayColor: textColor,
    ),
  );
}
