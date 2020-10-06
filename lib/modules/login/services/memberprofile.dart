import 'dart:convert';

import 'package:api_handler/api_handler.dart';
import 'package:voyager/app_config.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/base/services/helper.dart';
import 'package:voyager/base/services/save_profile.dart';
import 'package:voyager/modules/login/services/response.dart';
import 'package:voyager/modules/login/services/tier_name.dart';
import 'package:voyager/modules/login/widgets/login_error.dart';

class MembershipProfile {
  final apiHandler = ApiHandler(AppConfig.baseURL);
  ProfileModel profileModel = new ProfileModel();
  static Response responseObj;
  getMembershipProfile(String membershipNumber) async {
    {
      Map txnheader = {
        "transactionID": "",
        "userName": "mob-app",
        "timeStamp": Helper.getFormatedTime().toString()
      };
      Map memberProfileDetailsRequest = {
        "companyCode": "SA",
        "programCode": "VOYAG",
        "membershipNumber": membershipNumber,
        "emailAddress": "",
        "customerNumber": "",
        "firstName": "",
        "surName": "",
        "dateOfBirth": "",
        "mobileNumber": "",
        "passportNumber": "",
        "zipCode": "",
        "companyName": "",
        "city": "",
        "statesss": "",
        "country": "",
        "txnHeader": txnheader,
      };
      Map bodyMap = {
        "MemberProfileDetailsRequest": memberProfileDetailsRequest
      };
      var body = jsonEncode(bodyMap);
      return await memberProfile(AppConfig.retreiveMemberProfileURL, body);
    }
  }

  isNil(item) {
    return item.toString().contains("nil");
  }

  Future<ProfileModel> memberProfile(String path, body) async {
    int code = 500;
    ApiResponse response;
    Response respObj = Response();
    responseObj = respObj;
    while (code == 500) {
      response = await apiHandler.requestWith(
        path: "$path",
        type: RequestType.post,
        body: body,
      );
      code = response.code;
    }
    if (response != null) {
      respObj.setMemberProfile = response;
      if (code == 200) {
        Map responseBody = json.decode(response.body);
        if (response.body.contains("Fault")) {
          LoginErrorAlert.setError(respObj);
        }

        if (response.body.contains("MemberProfileDetailsResponse")) {
          Map profileResponse = responseBody['MemberProfileDetailsResponse'];

          Map memberAccount = profileResponse['memberAccount'];

          profileModel.membershipId =
              (memberAccount['membershipNumber'].toString());
          profileModel.accountStatus =
              (memberAccount['accountStatus'].toString());

          if (isNil(memberAccount['enrolmentSource'])) {
            profileModel.enrolmentSource = "NA";
          } else {
            profileModel.enrolmentSource =
                (memberAccount['enrolmentSource'].toString());
          }
          if (isNil(memberAccount['enrollmentSourceCode'])) {
            profileModel.enrollmentSourceCode = "NA";
          } else {
            profileModel.enrollmentSourceCode =
                (memberAccount['enrollmentSourceCode'].toString());
          }

          if (isNil(memberAccount['enrolmentDate'])) {
            profileModel.enrolmentDate = "NA";
          } else {
            profileModel.enrolmentDate = (memberAccount['enrolmentDate']);
          }

          profileModel.periodType = (memberAccount['periodType']);
          profileModel.period = (memberAccount['period']);
          profileModel.extendToDay = (memberAccount['extendToDay']);
          profileModel.extendToMonth = (memberAccount['extendToMonth']);
          profileModel.tier = (memberAccount['tier'].toString());

          if (isNil(memberAccount['tierFromDate'])) {
            profileModel.tierFromDate = "NA";
          } else {
            profileModel.tierFromDate = (memberAccount['tierFromDate']);
          }

          if (isNil(memberAccount['tierToDate'])) {
            profileModel.tierToDate = "NA";
          } else {
            profileModel.tierToDate = (memberAccount['tierToDate']);
          }

          profileModel.tierName = TierName().getTierName(memberAccount['tier']);
          profileModel.tierColor =
              TierName().getTierColor(memberAccount['tier']);
          profileModel.nextTierName =
              TierName().getNextTier(memberAccount['tier']);
          Map memberProfile = memberAccount['memberProfile'];

          profileModel.customerNumber =
              (memberProfile['customerNumber'].toString());
          profileModel.membershipType = (memberProfile['membershipType']);
          profileModel.membershipStatus = (memberProfile['membershipStatus']);

          if (isNil(memberProfile['secretQuestion'])) {
            profileModel.secretQues = "NA";
          } else {
            profileModel.secretQues = (memberProfile['secretQuestion']);
          }
          if (isNil(memberProfile['secretAnswer'])) {
            profileModel.secretAns = "NA";
          } else {
            profileModel.secretAns = (memberProfile['secretAnswer']);
          }

          Map individualInfo = memberProfile['individualInfo'];

          profileModel.title = (individualInfo['title']);
          profileModel.memberNationality =
              (individualInfo['memberNationality']);
          profileModel.givenName = (individualInfo['givenName']);
          profileModel.familyName = (individualInfo['familyName']);
          profileModel.initials = (individualInfo['initials']);
          profileModel.gender = (individualInfo['gender']);

          if (isNil(individualInfo['maritalStatus'])) {
            profileModel.maritalStatus = "NA";
          } else {
            profileModel.maritalStatus = (individualInfo['maritalStatus']);
          }

          profileModel.dateOfBirth = (individualInfo['dateOfBirth']);
          profileModel.passportNumber =
              (individualInfo['passportNumber'].toString());
          if (isNil(individualInfo['idNumber'])) {
            profileModel.idNumber = "NA";
          } else {
            profileModel.idNumber = (individualInfo['idNumber'].toString());
          }

          if (isNil(individualInfo['companyName'])) {
            profileModel.companyName = "NA";
          } else {
            profileModel.companyName = (individualInfo['companyName']);
          }

          profileModel.preferredAddress = (individualInfo['preferredAddress']);
          profileModel.preferredLanguage =
              (individualInfo['preferredLanguage']);

          var memberContactInfos = individualInfo['memberContactInfos'];
          Map memberContactInfo = null;
          if (memberContactInfos is List) {
            for (int i = 0; i < memberContactInfos.length; i++) {
              Map contactInfo = memberContactInfos[i];
              String addressType = contactInfo['addressType'];
              if (addressType == 'H') {
                memberContactInfo = contactInfo;
              }
            }
          } else if (memberContactInfos is Map) {
            memberContactInfo = memberContactInfos;
          }
          if (memberContactInfo != null) {
            profileModel.addressType = memberContactInfo['addressType'];
            profileModel.addressLine1 = memberContactInfo['addressLine1'];
            profileModel.addressLine2 = memberContactInfo['addressLine2'];
            profileModel.city = memberContactInfo['city'];
            profileModel.state = memberContactInfo['state'];
            profileModel.country = memberContactInfo['country'];
            profileModel.zipCode = memberContactInfo['zipCode'].toString();
            profileModel.emailAddress = memberContactInfo['emailAddress'];
            profileModel.phoneAreaCode =
                memberContactInfo['phoneAreaCode'].toString();
            profileModel.phoneISDCode =
                memberContactInfo['phoneISDCode'].toString();
            profileModel.phoneNumber =
                memberContactInfo['phoneNumber'].toString();
            profileModel.mobileISDCode =
                memberContactInfo['mobileISDCode'].toString();
            profileModel.mobileAreaCode =
                memberContactInfo['mobileAreaCode'].toString();
            profileModel.mobileNumber =
                memberContactInfo['mobileNumber'].toString();
            profileModel.faxISDCode =
                memberContactInfo['faxISDCode'].toString();

            if (isNil(memberContactInfo['faxAreaCode'])) {
              profileModel.faxAreaCode = "NA";
            } else {
              profileModel.faxAreaCode =
                  (memberContactInfo['faxAreaCode'].toString());
            }
            if (isNil(memberContactInfo['fax'])) {
              profileModel.fax = "NA";
            } else {
              profileModel.fax = (memberContactInfo['fax'].toString());
            }
          } else {
            profileModel.addressType = "";
            profileModel.addressLine1 = "";
            profileModel.addressLine2 = "";
            profileModel.city = "";
            profileModel.state = "";
            profileModel.country = "";
            profileModel.zipCode = "";
            profileModel.emailAddress = "";
            profileModel.phoneAreaCode = "";
            profileModel.phoneISDCode = "";
            profileModel.phoneNumber = "";
            profileModel.mobileISDCode = "";
            profileModel.mobileAreaCode = "";
            profileModel.mobileNumber = "";
            profileModel.faxISDCode = '';
            profileModel.faxAreaCode = "";
            profileModel.fax = "";
          }
          SaveGetProfile().saveProfile(profileModel);

          return profileModel;
        } else if (response.body.contains('Fault')) {
          Map memberAccount = responseBody['Fault'];
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
