import 'package:flutter/material.dart';

class ForgotPinStatus {
  static String errorMsg;

  static setErroMsg(Map fault) {
    Map details = fault['detail'];
    Map error = details['MemberWebServiceException'];
    String msg = error['faultstring'];
    if (msg == "program.member.ResetPinFailed") {
      errorMsg = "Email Address or Membership Number is incorrect !!";
    } else {
      errorMsg = "Unexpected Error occured. Please Try Again !!";
    }
    return errorMsg;
  }

  static displaySnackBar(_scaffoldKey, String msg) {
    print(errorMsg);

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
