import 'package:flutter/material.dart';

class UpdateStatus {
  static displaySnackBar(_scaffoldKey, String errorMsg) {
    final SnackBar snackBar = SnackBar(
        content: Text(
          errorMsg,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
