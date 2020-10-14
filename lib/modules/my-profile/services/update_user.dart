import 'dart:convert';

import 'package:api_handler/api_handler.dart';
import 'package:intl/intl.dart';
import 'package:voyager/app_config.dart';
import 'package:voyager/base/models/account_model.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/modules/login/services/memberprofile.dart';
import 'package:voyager/modules/login/services/response.dart';
import 'package:voyager/modules/my-profile/widgets/error_snackbar.dart';

class UpdateUser {
  ProfileModel profileModel = LoginUser.profileModel;

  final apiHandler = ApiHandler(AppConfig.baseURL);

  updateUser(Map data, scaffoldKey) async {
    var body = await getMemberProfileData(data);

    int code = 500;
    ApiResponse response;
    Response respObj = Response();
    while (code == 500) {
      print(body);
      response = await apiHandler.requestWith(
        path: AppConfig.enrollmentURL,
        type: RequestType.post,
        body: body,
      );
      code = response.code;

      if (response != null) {
        // int code = response.code;
        print(response.body);
        if (code == 200) {
          // respObj.setEnrollUser = response;
          Map res = json.decode(response.body);
          if (response.body.contains("EnrolMemberResponse")) {
            // Map enrolMemberResponse = res['EnrolMemberResponse'];
            // Map memberActivityStatus =
            //     enrolMemberResponse['MemberActivityStatus'];
            // print(memberActivityStatus);
            // if (memberActivityStatus.containsKey('membershipNumber')) {
            //   print("Membership NO: )");
            //   print(memberActivityStatus['membershipNumber']);
            //   return 'true';
            // }
            MembershipProfile().getMembershipProfile(profileModel.membershipId);
            UpdateStatus.displaySnackBar(scaffoldKey, "Updated Profile");
            return "true";
          } else if (response.body.contains('Fault')) {
            //EnrollmentError.setError(respObj);
            //  print(res['Fault']['details']);
            try {
              String fault = res['Fault']['detail']['MemberWebServiceException']
                  ['faultstring'];
              UpdateStatus.displaySnackBar(scaffoldKey, fault);
            } on Exception catch (e) {
              UpdateStatus.displaySnackBar(scaffoldKey,
                  "Something Unexpected occured! Please try again!!");
            }

            return 'fault';
          }
          // } else if (code == 500) {
          //   return 'connectionRefused';
        }
      }
    }
  }

  getMemberProfileData(Map data) {
    String enrolmentDate = profileModel.enrolmentDate.substring(0, 11);
    print(profileModel.country);
    Map txnheader = {
      "transactionID": "",
      "userName": "mob-app",
      "timeStamp": "2020-09-21T14:31:40.815Z"
    };

    Map paymentDetail = {
      "pointsCollected": "0",
      "amountCollected": "0",
      "paymentType": "",
      "currencyCode": "",
      "paymentSource": "",
      "quoteReferenceNumber": "",
      "paymentGateWayRefNumber": "",
      "bankRefNumber": "",
      "cardType": "",
      "cardHolderName": "",
    };
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
    Map memberContactInfo = {
      "addressType": "B",
      "addressLine1": data["addressLine1"],
      "addressLine2": data["addressLine2"],
      "city": data["city"],
      "state": data["state"],
      "country": data["nation"],
      "zipCode": data["zipcode"],
      "emailAddress": data["email"],
      "phoneISDCode": profileModel.phoneISDCode,
      "phoneAreaCode": profileModel.phoneAreaCode,
      "phoneNumber": profileModel.phoneNumber,
      "mobileISDCode": data["countryCode"],
      "mobileAreaCode": data["areaCode"],
      "mobileNumber": data["phone"],
      "faxISDCode": profileModel.faxISDCode,
      "faxAreaCode": profileModel.faxAreaCode,
      "fax": profileModel.fax,
      "skypeID": profileModel.skypeID,
      "operationFlag": "U"
    };

    Map corporateInfo = {
      "companyName": profileModel.companyName,
      "companyID": "",
      "industryType": "",
      "numberOfEmployees": "",
      "preferredLanguage": profileModel.preferredLanguage,
      "website": "",
      "contactPersonName": "",
      "contactPersonDesignation": "",
      "contactPersonEmailAddress": "",
      "contactPersonPhoneISDCode": "",
      "contactPersonPhoneAreaCode": "",
      "contactPersonPhoneNumber": "",
      "operationFlag": "",
      "memberContactInfo": memberContactInfo,
    };
    Map memberContactInfos = {
      "addressType": "H",
      "addressLine1": data["addressLine1"],
      "addressLine2": data["addressLine2"],
      "city": data["city"],
      "state": data["state"],
      "country": data["nation"],
      "zipCode": data["zipcode"],
      "emailAddress": data["email"],
      "phoneISDCode": profileModel.phoneISDCode,
      "phoneAreaCode": profileModel.phoneAreaCode,
      "phoneNumber": profileModel.phoneNumber,
      "mobileISDCode": data["countryCode"],
      "mobileAreaCode": data["areaCode"],
      "mobileNumber": data["phone"],
      "faxISDCode": profileModel.faxISDCode,
      "faxAreaCode": profileModel.faxAreaCode,
      "fax": profileModel.fax,
      "skypeID": profileModel.skypeID,
      "operationFlag": "U"
    };

    Map individualInfo = {
      "memberNationality": profileModel.memberNationality,
      "preferredLanguage": profileModel.preferredLanguage,
      "preferredAddress": "H",
      "title": profileModel.title,
      "givenName": profileModel.givenName,
      "familyName": profileModel.familyName,
      "displayName": profileModel.givenName,
      "initials": profileModel.initials,
      "gender": profileModel.gender,
      "maritalStatus": profileModel.maritalStatus,
      "dateOfBirth": profileModel.dateOfBirth,
      "passportNumber": profileModel.passportNumber,
      "countryOfResidence": data["nation"],
      "idNumber": profileModel.idNumber,
      "staffID": "",
      "companyName": profileModel.companyName,
      "designation": "",
      "industryType": "",
      "incomeBand": "",
      "operationFlag": "",
      "memberContactInfos": memberContactInfos,
    };

    Map memberProfile = {
      "companyCode": "SA",
      "membershipNumber": profileModel.membershipId,
      "customerPassword": "",
      "customerNumber": profileModel.customerNumber,
      "membershipType": profileModel.membershipType,
      "membershipStatus": profileModel.membershipStatus,
      "enrollmentSource": profileModel.enrolmentSource,
      "enrollmentSourceCode": profileModel.enrollmentSourceCode,
      "secretQuestion": profileModel.secretQues,
      "secretAnswer": profileModel.secretAns,
      "operationFlag": "U",
      "individualInfo": individualInfo,
      "corporateInfo": corporateInfo,
      "pin": ""
    };

    Map memberAcc = {
      "companyCode": "SA",
      "programCode": "VOYAG",
      "membershipNumber": profileModel.membershipId,
      "accountStatus": profileModel.accountStatus,
      "enrolmentSource": profileModel.enrolmentSource,
      "enrollmentSourceCode": profileModel.enrollmentSourceCode,
      "enrolmentDate": enrolmentDate,
      "periodType": profileModel.periodType,
      "period": profileModel.period,
      "extendToDay": profileModel.extendToDay,
      "extendToMonth": profileModel.extendToMonth,
      "tier": profileModel.tier,
      "tierFromDate": profileModel.tierFromDate,
      "tierToDate": profileModel.tierToDate,
      "operationFlag": "U",

      "memberProfile": memberProfile,
      // "memberPreferences": memberPreferences,
      "memberDynamicAttributes": memberDynamicAttributes,
      "accountReferralDetail": accountReferralDetail,
    };
    Map enrolMemberRequest = {
      "memberAccount": memberAcc,
      "paymentDetail": paymentDetail,
      "txnHeader": txnheader,
    };
    Map enrolMemberRequestMain = {"EnrolMemberRequest": enrolMemberRequest};

    var body = jsonEncode(enrolMemberRequestMain);
    //print(body);

    return body;
  }
}
