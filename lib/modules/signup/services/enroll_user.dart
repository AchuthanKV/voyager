import 'dart:convert';

import 'package:api_handler/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:voyager/app_config.dart';
import 'package:voyager/base/models/enrollment_model.dart';
import 'package:voyager/modules/login/services/response.dart';
import 'package:voyager/modules/signup/services/enroll_error.dart';
import 'package:voyager/services/api_service.dart';

class EnrollUser {
  //String membershipId;
  //String pin;
  var body;
  EnrollmentModel enrollmentModel = new EnrollmentModel();
  final apiHandler = ApiHandler(AppConfig.baseURL);
  static String errorMsg = "";

  enrollUser(Map data) async {
    setEnrollProfileDetails(data);
    getEnrollProfileDetails(data);
    body = getEnrollmentDataBody();
    // print(body);
    var response = "connectionRefused";
    try {
      while (response == "connectionRefused") {
        response = await enrollmentStatus(AppConfig.enrollmentURL, body);
      }
      return response;
    } catch (e) {
      print(e);
    }
  }

  void setEnrollProfileDetails(Map data) {
    enrollmentModel.setTitle = data["title"].toString().trim();
    enrollmentModel.setFname = data["firstName"].toString().trim();
    enrollmentModel.setLastName = data["lastName"].toString().trim();
    enrollmentModel.setAreaCode = data["areaCode"].toString().trim();
    enrollmentModel.seMobile = data["phone"].toString().trim();
    enrollmentModel.setDob = data["dob"].toString().trim();
    enrollmentModel.setGender = data["gender"].toString().trim();
    enrollmentModel.setCountryOfResidance =
        data["nationCode"].toString().trim();
    enrollmentModel.setEmailPromotion = data["emailOn"];
    enrollmentModel.setEmail = data["email"].toString().trim();
    enrollmentModel.setIsdCode = data["countryCode"].toString().trim();
    enrollmentModel.setIdentityNumber =
        data["identityNumber"].toString().trim();
    enrollmentModel.setPassportNumber =
        data["passportNumber"].toString().trim();
    enrollmentModel.setEnrollmentDate =
        data["enrollmentDate"].toString().trim();
    enrollmentModel.setInitials = data["initials"].toString().trim();
  }

  void getEnrollProfileDetails(Map data) {
    print(enrollmentModel.getTitle);
    print(enrollmentModel.getFname);
    print(enrollmentModel.getLastName);
    print(enrollmentModel.getAreaCode);
    print(enrollmentModel.getMobile);
    print(enrollmentModel.getDob);
    print(enrollmentModel.getGender);
    print(enrollmentModel.getCountryOfResidance);
    print(enrollmentModel.getEmailPromotion);
    print(enrollmentModel.getEmail);
    print(enrollmentModel.getIsdCode);
    print(enrollmentModel.getIdentityNumber);
    print(enrollmentModel.getPassportNumber);
    print(enrollmentModel.getEnrollmentDate);
    print(enrollmentModel.getInitials);
  }

  Future enrollmentStatus(String path, body) async {
    int code = 500;
    ApiResponse response;
    Response respObj = Response();
    while (code == 500) {
      response = await apiHandler.requestWith(
        path: "$path",
        type: RequestType.post,
        body: body,
      );

      if (response != null) {
        int code = response.code;

        if (code == 200) {
          respObj.setEnrollUser = response;
          Map res = json.decode(response.body);
          if (response.body.contains("EnrolMemberResponse")) {
            print(response);
            Map enrolMemberResponse = res['EnrolMemberResponse'];
            Map memberActivityStatus =
                enrolMemberResponse['MemberActivityStatus'];
            print(memberActivityStatus);
            if (memberActivityStatus.containsKey('membershipNumber')) {
              print("Membership NO: )");
              print(memberActivityStatus['membershipNumber']);
              return 'true';
            }
          } else if (response.body.contains('Fault')) {
            print("FaultFaultFault");
            EnrollmentError.setError(respObj);
            return 'fault';
          }
        } else if (code == 500) {
          return 'connectionRefused';
        }
      }
    }
  }

  getEnrollmentDataBody() {
    Map txnheader = {
      "transactionID": "",
      "userName": "mob-app",
      "timeStamp": "2020-09-21T14:31:40.815Z"
    };
    List memberPreferences = [
      {
        "preferenceCode": 1,
        "sequenceNumber": 1,
        "preferenceValue": "E",
        "type": "C",
        "operationFlag": "I"
      },
      {
        "preferenceCode": 8,
        "sequenceNumber": 1,
        "preferenceValue":
            enrollmentModel.getEmailPromotion == true ? "Y" : "E",
        "type": "C",
        "operationFlag": "I"
      }
    ];
    Map accountReferralDetailAttribute = {
      "referenceKey": "",
      "referenceValue": "",
      "operationFlag": ""
    };

    Map memberDynamicAttributes = {
      "attributeCode": "",
      "attributeValue": "",
      "type": "",
      "operationFlag": ""
    };

    Map accountReferralDetail = {
      "referenceType": "",
      "referenceMembershipNumber": "",
      "accountReferralDetailAttribute": accountReferralDetailAttribute,
      "operationFlag": ""
    };

    Map memberContactInfos = {
      "addressType": "H",
      "addressLine1": "NA",
      "addressLine2": "NA",
      "city": "NA",
      "state": "NA",
      "country": enrollmentModel.getCountryOfResidance,
      "zipCode": "",
      "emailAddress": enrollmentModel.getEmail,
      "phoneISDCode": "0",
      "phoneAreaCode": "0",
      "phoneNumber": "0",
      "mobileISDCode": enrollmentModel.getIsdCode,
      "mobileAreaCode": enrollmentModel.getAreaCode,
      "mobileNumber": enrollmentModel.getMobile,
      "fax": "",
      "skypeID": "",
      "operationFlag": ""
    };

    Map individualInfo = {
      "memberNationality": enrollmentModel.getCountryOfResidance,
      "preferredLanguage": "EN",
      "preferredAddress": "H",
      "title": enrollmentModel.getTitle,
      "givenName": enrollmentModel.getFname,
      "familyName": enrollmentModel.getLastName,
      "displayName": "",
      "initials": enrollmentModel.getInitials,
      "gender": enrollmentModel.getGender,
      "maritalStatus": "S",
      "dateOfBirth": enrollmentModel.getDob,
      "passportNumber": enrollmentModel.getPassportNumber,
      "countryOfResidence": enrollmentModel.getCountryOfResidance,
      "idNumber": enrollmentModel.getIdentityNumber,
      "memberContactInfos": memberContactInfos,
    };

    Map memberProfile = {
      "companyCode": "SA",
      "membershipType": "I",
      "membershipStatus": "A",
      "enrollmentSource": "M",
      "enrollmentSourceCode": "M",
      "secretQuestion": "",
      "secretAnswer": "",
      "operationFlag": "I",
      "individualInfo": individualInfo,
      "pin": "1234"
    };

    Map memberAcc = {
      "companyCode": "SA",
      "programCode": "VOYAG",
      "accountStatus": "A",
      "enrolmentSource": "M",
      "enrollmentSourceCode": "M",
      "enrolmentDate": enrollmentModel.getEnrollmentDate,
      "periodType": "U",
      "period": 0,
      "extendToDay": 0,
      "extendToMonth": 0,
      "operationFlag": "I",
      "memberProfile": memberProfile,
      "memberPreferences": memberPreferences,
      "memberDynamicAttributes": memberDynamicAttributes,
      "accountReferralDetail": accountReferralDetail,
    };

    Map data = {"memberAccount": memberAcc, "txnHeader": txnheader};
    Map head = {"EnrolMemberRequest": data};
    body = jsonEncode(head);
    //print(body);
    return body;
  }
}
