import 'dart:convert';

import 'package:api_handler/api_handler.dart';
import 'package:voyager/app_config.dart';
import 'package:voyager/base/models/profile_model.dart';

class MembershipProfile {
  final apiHandler = ApiHandler(AppConfig.baseURL);
  ProfileModel profileModel = new ProfileModel();
  getMembershipProfile(String membershipNumber) async {
    {
      Map txnheader = {
        "transactionID": "",
        "userName": "mob-app",
        "timeStamp": "2020-07-20T10:01:32.131Z"
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

  Future<ProfileModel> memberProfile(String path, body) async {
    ApiResponse response = await apiHandler.requestWith(
      path: "$path",
      type: RequestType.post,
      body: body,
    );
    if (response != null) {
      int code = response.code;

      if (code == 200) {
        Map responseBody = json.decode(response.body);
        if (response.body.contains("MemberProfileDetailsResponse")) {
          Map profileResponse = responseBody['MemberProfileDetailsResponse'];

          Map memberAccount = profileResponse['memberAccount'];

          profileModel.membershipId = (memberAccount['membershipNumber']);
          profileModel.accountStatus = (memberAccount['accountStatus']);
          profileModel.enrolmentSource = (memberAccount['enrolmentSource']);
          profileModel.enrollmentSourceCode =
              (memberAccount['enrollmentSourceCode']);
          profileModel.enrolmentDate = (memberAccount['enrolmentDate']);
          profileModel.periodType = (memberAccount['periodType']);
          profileModel.period = (memberAccount['period']);
          profileModel.extendToDay = (memberAccount['extendToDay']);
          profileModel.extendToMonth = (memberAccount['extendToMonth']);
          profileModel.tier = (memberAccount['tier']);
          profileModel.tierFromDate = (memberAccount['tierFromDate']);
          profileModel.tierToDate = (memberAccount['tierToDate']);

          Map memberProfile = memberAccount['memberProfile'];

          profileModel.customerNumber = (memberProfile['customerNumber']);
          profileModel.membershipType = (memberProfile['membershipType']);
          profileModel.membershipStatus = (memberProfile['membershipStatus']);
          profileModel.secretQues = (memberProfile['secretQuestion']);
          profileModel.secretAns = (memberProfile['secretAnswer']);

          Map individualInfo = memberProfile['individualInfo'];

          profileModel.title = (individualInfo['title']);
          profileModel.memberNationality =
              (individualInfo['memberNationality']);
          profileModel.givenName = (individualInfo['givenName']);
          profileModel.familyName = (individualInfo['familyName']);
          profileModel.initials = (individualInfo['initials']);
          profileModel.gender = (individualInfo['gender']);
          profileModel.maritalStatus = (individualInfo['maritalStatus']);
          profileModel.dateOfBirth = (individualInfo['dateOfBirth']);
          profileModel.passportNumber = (individualInfo['passportNumber']);
          profileModel.idNumber = (individualInfo['idNumber']);
          profileModel.companyName = (individualInfo['companyName']);
          profileModel.preferredAddress = (individualInfo['preferredAddress']);
          profileModel.preferredLanguage =
              (individualInfo['preferredLanguage']);

          List memberContactInfos = individualInfo['memberContactInfos'];
          Map memberContactInfo = null;
          for (int i = 0; i < memberContactInfos.length; i++) {
            Map contactInfo = memberContactInfos[i];
            String addressType = contactInfo['addressType'];
            if (addressType == 'H') {
              memberContactInfo = contactInfo;
            }
          }
          if (memberContactInfo != null) {
            profileModel.addressType = memberContactInfo['addressType'];
            profileModel.addressLine1 = memberContactInfo['addressLine1'];
            profileModel.addressLine2 = memberContactInfo['addressLine2'];
            profileModel.city = memberContactInfo['city'];
            profileModel.state = memberContactInfo['state'];
            profileModel.country = memberContactInfo['country'];
            profileModel.zipCode = memberContactInfo['zipCode'];
            profileModel.emailAddress = memberContactInfo['emailAddress'];
            profileModel.phoneAreaCode = memberContactInfo['phoneAreaCode'];
            profileModel.phoneISDCode = memberContactInfo['phoneISDCode'];
            profileModel.phoneNumber = memberContactInfo['phoneNumber'];
            profileModel.mobileISDCode = memberContactInfo['mobileISDCode'];
            profileModel.mobileAreaCode = memberContactInfo['mobileAreaCode'];
            profileModel.mobileNumber = memberContactInfo['mobileNumber'];
            profileModel.faxISDCode = memberContactInfo['faxISDCode'];
            profileModel.faxAreaCode = memberContactInfo['faxAreaCode'];
            profileModel.fax = memberContactInfo['fax'];
          } else {
            profileModel.addressType = "";
            profileModel.addressLine1 = "";
            profileModel.addressLine2 = "";
            profileModel.city = "";
            profileModel.state = "";
            profileModel.country = "";
            profileModel.zipCode = 0;
            profileModel.emailAddress = "";
            profileModel.phoneAreaCode = "";
            profileModel.phoneISDCode = "";
            profileModel.phoneNumber = 0;
            profileModel.mobileISDCode = "";
            profileModel.mobileAreaCode = 0;
            profileModel.mobileNumber = 0;
            profileModel.faxISDCode = "";
            profileModel.faxAreaCode = "";
            profileModel.fax = "";
          }
          return profileModel;
        } else if (response.body.contains('Fault')) {
          Map memberAccount = responseBody['Fault'];
          return null;
        }
      } else {
        return null;
      }
    }
  }
}
