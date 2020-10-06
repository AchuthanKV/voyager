import 'dart:convert';

import 'package:api_handler/api_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/app_config.dart';
import 'package:voyager/base/models/account_model.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/base/services/helper.dart';
import 'package:voyager/base/services/save_account.dart';
import 'package:voyager/base/services/save_profile.dart';
import 'package:voyager/modules/home/pages/landing_home_page.dart';
import 'package:voyager/modules/login/services/accountsummary.dart';
import 'package:voyager/modules/login/services/memberprofile.dart';
import 'package:voyager/modules/login/widgets/login_error.dart';
import 'package:voyager/services/api_service.dart';

class LoginUser {
  FlutterSecureStorage _storage = FlutterSecureStorage();
  String savedMembershipId;
  String savedPin;
  var body;
  static ProfileModel profileModel;
  static AccountModel accountModel;
  static String errorMsg = "";

  getStoredValue() async {
    savedMembershipId = await _storage.read(key: 'membershipId');
    savedPin = await _storage.read(key: 'pin');
  }

  authenticateUser(String membershipId, String pin) async {
    getStoredValue();
    String date = Helper.getFormatedTime().toString();
    SaveGetProfile().getProfile();
    SaveGetAccount().getAccount();
    print(date);
    Map txnheader = {
      "transactionID": "",
      "userName": "mob-app",
      "timeStamp": date
    };
    Map data = {
      'companyCode': 'SA',
      "programCode": "VOYAG",
      "membershipNumber": membershipId,
      "pin": pin,
      "skipPinChangeReminder": 1,
      "txnHeader": txnheader,
    };
    Map head = {"AuthenticateMemberRequest": data};
    body = jsonEncode(head);
    var response = "connectionRefused";

    try {
      while (response == "connectionRefused") {
        response = await ApiService().userStatus(AppConfig.loginAuthURL, body);
      }

      if (response == 'true') {
        LoginUser.profileModel = SaveGetProfile.profileModel;
        LoginUser.accountModel = SaveGetAccount.accountModel;

        if (profileModel != null &&
            accountModel != null &&
            membershipId == savedMembershipId) {
          LandingPage.callApi = true;
          return "true";
        } else {
           LandingPage.callApi = false;
          profileModel =
              await MembershipProfile().getMembershipProfile(membershipId);

          accountModel = await AccountSummary().getAccountSummary(membershipId);

          return 'true';
        }
      } else if (response == "fault") {
        return 'fault';
      } else {
        return "false";
      }
    } on CommonError catch (e) {
      print(e.description);
      LoginErrorAlert.errorMsg = e.description;
    } on Exception catch (e) {
      LoginErrorAlert.errorMsg =
          "Something unexpected Occurred! Please try again!";
    }
  }
}
