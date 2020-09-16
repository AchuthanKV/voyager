import 'package:flutter/material.dart';

class ChangepinStatus {
  static String errorMsg;

  static setErroMsg(Map fault) {
    Map details = fault['detail'];
    Map error = details['MemberWebServiceException'];
    String msg = error['faultstring'];
    if (msg == "member.profile.OldPinDoesNotMatch") {
      errorMsg = "Old Pin does not Match!! ";
    } else if (msg == "member.profile.SimilarPinException") {
      errorMsg = "New Pin is similar to Old Pin. Try Again!!";
    } else {
      errorMsg = "Unexpected Erro occured. Try Again!!";
    }
    return errorMsg;
  }

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
