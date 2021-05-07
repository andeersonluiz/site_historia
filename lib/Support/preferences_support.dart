import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String email_code = "Email";

  static saveLogin(String email) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    prefs.setString(email_code, email);
  }

  static deleteLogin() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    prefs.setString(email_code, "");
  }
}
