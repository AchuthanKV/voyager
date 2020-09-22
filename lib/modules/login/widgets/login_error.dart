import 'dart:convert';

import 'package:api_handler/api_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/modules/login/pages/login_screen.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/modules/login/services/response.dart';

class LoginErrorAlert {
  static String errorMsg;

  static setError(Response respObj) {
    Map res;
    if (respObj.getLoginAuth.body.contains('Fault')) {
      res = json.decode(respObj.loginAuth.body);
    } else if (respObj.getMemberProfile.body.contains('Fault')) {
      res = json.decode(respObj.getMemberProfile.body);
    } else if (respObj.getAccountSummary.body.contains('Fault')) {
      res = json.decode(respObj.getAccountSummary.body);
    }

    Map fault = res['Fault'];
    Map details = fault['detail'];
    Map error = details['MemberWebServiceException'];
    String msg = error['faultstring'];
    if (msg == "program.member.MemberDoesNotExist") {
      errorMsg = "Invalid membership number!";
    } else if (msg == "member.profile.PinDoesNotMatch") {
      errorMsg = "Invalid pin!";
    } else if (msg == "") {
      errorMsg = "Invalid pin!";
    } else if (msg == "member.profile.WebAccountNotActivated") {
      errorMsg = "Account is not active!";
    } else if (msg == "member.profile.WebAccountBlocked") {
      errorMsg = "Your account is locked ! Please contact our call centre.";
    } else {
      errorMsg = "Something Unexpected Occurred! Please try again.";
    }
  }

  static displaySnackBar(_scaffoldKey) {
    print(errorMsg);
    print("*********");
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
