import 'package:flutter/material.dart';

class WishlistStatus {
  static String errorMsg;

  static displaySnackBar(_scaffoldKey, String msg) {
    final SnackBar snackBar = SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
