import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/app_config.dart';
import 'package:voyager/base/models/account_model.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/modules/login/services/accountsummary.dart';
import 'package:voyager/modules/login/services/memberprofile.dart';
import 'package:voyager/modules/login/services/response.dart';
import 'package:voyager/services/api_service.dart';

class LoginUser {
  FlutterSecureStorage _storage = FlutterSecureStorage();
  String membershipId;
  String pin;
  var body;
  static ProfileModel profileModel;
  static AccountModel accountModel;

  getStoredValue() async {
    membershipId = await _storage.read(key: 'membershipId');
    pin = await _storage.read(key: 'pin');
  }

  authenticateUser(String membershipId, String pin) async {
    Map txnheader = {
      "transactionID": "",
      "userName": "mob-app",
      "timeStamp": "2020-07-20T10:01:32.131Z"
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
    while (response == "connectionRefused") {
      response = await ApiService().userStatus(AppConfig.loginAuthURL, body);
    }

    if (response == 'true') {
      profileModel =
          await MembershipProfile().getMembershipProfile(membershipId);
      accountModel = await AccountSummary().getAccountSummary(membershipId);

      return 'true';
    } else {
      return 'false';
    }
  }
}
