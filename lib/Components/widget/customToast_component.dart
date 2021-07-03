/// Widget responsável por padronizar a exibição do Toast.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library CustomToast;
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static showToast(String msg, Color color) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
