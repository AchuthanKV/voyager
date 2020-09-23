import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:voyager/modules/login/services/response.dart';

class EnrollmentError {
  static String errorMsg;

  static setError(Response respObj) {
    try {
      Map res = json.decode(respObj.enrollUser.body);

      Map fault = res['Fault'];
      print(fault);
      Map details = fault['detail'];
      Map error = details['MemberWebServiceException'];
      String msg = error['faultstring'];
      print(msg);

      if (equalsIgnoreCase(
          msg, "program.member.DuplicateMemberProfilesExistsAsPerAlgorithm")) {
        errorMsg = "Member already exists";
      } else if (equalsIgnoreCase(msg, "program.member.MemberTitleInvalid")) {
        errorMsg = "Invalid Member Title";
      } else if (equalsIgnoreCase(
          msg, "program.member.dateOfBirthGreaterThanCurrentDate")) {
        errorMsg = "Date of birth greater than current date";
      } else if (equalsIgnoreCase(msg, "program.member.InvalidAge")) {
        errorMsg = "Invalid age";
      } else if (equalsIgnoreCase(
          msg, "customer.profile.InvalidIdNumberLength")) {
        errorMsg = "Invalid ID number";
      } else if (equalsIgnoreCase(msg, "program.member.TitleGenderMismatch")) {
        errorMsg = "Title and gender invalid";
      } else if (equalsIgnoreCase(
          msg, "customer.profile.InvalidIdNumberDateOfBirthMisMatch")) {
        errorMsg = "ID No. and Date of birth mismatched";
      } else if (equalsIgnoreCase(
          msg, "customer.profile.InvalidIdNumberWithGender")) {
        errorMsg = "ID No. entered is invalid";
      } else {
        msg = "Enrolment failed";
      }
    } catch (e) {
      errorMsg = "User registration failed";
    }
  }

  static bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
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
