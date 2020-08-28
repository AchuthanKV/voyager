import 'dart:convert';

import 'package:api_handler/api_handler.dart';
import 'package:voyager/app_config.dart';
import 'package:voyager/base/models/account_model.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/modules/login/services/response.dart';

class AccountSummary {
  final apiHandler = ApiHandler(AppConfig.baseURL);
  AccountModel accountModel = new AccountModel();
  int totalPoints;
  var ACCOUNT_ID;

  bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  checkAccountDetails() {
    ProfileModel profileObject = LoginUser.profileModel;
    //some db call

    ACCOUNT_ID = '0L';
  }

  setMapPoints(expiryDetails) {
    int points = expiryDetails['points'];
    String pointType = expiryDetails['pointType'];
    if (equalsIgnoreCase(pointType, "BONUS") ||
        equalsIgnoreCase(pointType, "BASE") ||
        equalsIgnoreCase(pointType, "PURCH") ||
        equalsIgnoreCase(pointType, "MNREINST") ||
        equalsIgnoreCase(pointType, "MNBONEXP")
        //added extra values as per requirement : from client(ref: customer journeys)
        ||
        equalsIgnoreCase(pointType, "REINST") ||
        equalsIgnoreCase(pointType, "RFBON01") ||
        equalsIgnoreCase(pointType, "RFBON02") ||
        equalsIgnoreCase(pointType, "RFBON03") ||
        equalsIgnoreCase(pointType, "MPURCH") ||
        equalsIgnoreCase(pointType, "1YRBON") ||
        equalsIgnoreCase(pointType, "6MBON") ||
        equalsIgnoreCase(pointType, "3MBON")) {
      totalPoints = points;
    }
  }

  setlistPoints(expiryDetails) {
    for (int i = 0; i < expiryDetails.length; i++) {
      Map item = expiryDetails[i];
      int points = item["points"];

      String pointType = item["pointType"];
      if (equalsIgnoreCase(pointType, "BONUS") ||
          equalsIgnoreCase(pointType, "BASE") ||
          equalsIgnoreCase(pointType, "PURCH") ||
          equalsIgnoreCase(pointType, "MNREINST") ||
          equalsIgnoreCase(pointType, "MNBONEXP")
          //added extra values as per requirement : from client(ref: customer journeys)
          ||
          equalsIgnoreCase(pointType, "REINST") ||
          equalsIgnoreCase(pointType, "RFBON01") ||
          equalsIgnoreCase(pointType, "RFBON02") ||
          equalsIgnoreCase(pointType, "RFBON03") ||
          equalsIgnoreCase(pointType, "MPURCH") ||
          equalsIgnoreCase(pointType, "1YRBON") ||
          equalsIgnoreCase(pointType, "6MBON") ||
          equalsIgnoreCase(pointType, "3MBON")) {
        totalPoints = totalPoints + points;
      }
    }
  }

  setAccountModel(accountSummaryResponse) {
    accountModel.setMembershipNumber =
        accountSummaryResponse['membershipNumber'].toString();
    accountModel.setAccountStatus = accountSummaryResponse['accountStatus'];
    accountModel.setPoints = (totalPoints).toString();

    accountModel.setTierCode = accountSummaryResponse['tierCode'].toString();

    accountModel.setTitle = accountSummaryResponse['title'];
    accountModel.setTierName = accountSummaryResponse['tierName'];

    // to handle Prospect Value
    var prospectTierValue = accountSummaryResponse['prospectTier'];
    if (prospectTierValue is List) {
      for (int i = 0; i < prospectTierValue.length; i++) {
        if (prospectTierValue[i] is Map) {
          Map m = prospectTierValue[i];
          if (m.containsKey("nil")) {
            accountModel.setProspectTier = "NA";
          }
        }
      }
    } else {
      accountModel.setProspectTier = (prospectTierValue.toString());
    }

    // to handle Tier date Value
    var tierDateValue = accountSummaryResponse['tierToDate'];

    if (tierDateValue is List) {
      for (int i = 0; i < tierDateValue.length; i++) {
        if (tierDateValue[i] is Map) {
          Map m = tierDateValue[i];
          if (m.containsKey("nil")) {
            accountModel.setTierValidityDate = "NA";
          }
        }
      }
    } else {
      accountModel.setTierValidityDate = tierDateValue;
    }

    List pointDetails = accountSummaryResponse['pointDetails'];
    for (int j = 0; j < pointDetails.length; j++) {
      Map memberPointTypeObj = pointDetails[j];

      String memberPointType = memberPointTypeObj['pointType'];

      if (equalsIgnoreCase(memberPointType, "TRMIL")) {
        accountModel.setPointType = memberPointType;
        accountModel.setTotalPointsAccured =
            memberPointTypeObj["totalAccuredpoints"].toString();

        accountModel.setPointsToNextTier =
            memberPointTypeObj["pointsToNextTier"].toString();
        accountModel.setPointsForTierRetention =
            memberPointTypeObj["pointsForTierRetention"].toString();
        accountModel.setTierPoints = memberPointTypeObj["points"].toString();
      }
    }

    if (ACCOUNT_ID == "0l") {
      //  ACCOUNT_ID = badapter
      //        .insertAccountData(accountSummary);
    } else {
      //  badapter.updateAccountDetails(
      //        accountSummary, ACCOUNT_ID);
    }
  }

  getAccountSummary(String membershipId) async {
    totalPoints = 0;
    int code = 500;
    ApiResponse response;
    var body = getBody(membershipId);
    String path = AppConfig.accountSummaryURL;
    while (code == 500) {
      response = await apiHandler.requestWith(
        path: "$path",
        type: RequestType.post,
        body: body,
      );
      code = response.code;
    }

    if (response != null) {
      Response().setAccountSummary = response;
      if (code == 200) {
        Map responseBody = json.decode(response.body);
        if (response.body.contains("AccountSummaryResponse")) {
          Map accountSummaryResponse = responseBody['AccountSummaryResponse'];
          if (accountSummaryResponse != null) {
            if (accountSummaryResponse.containsKey("expiryDetails")) {
              var expiryDetails = accountSummaryResponse['expiryDetails'];
              if (expiryDetails != null) {
                if (expiryDetails is Map) {
                  setMapPoints(expiryDetails);
                } else if (expiryDetails is List) {
                  setlistPoints(expiryDetails);
                }
              }
              setAccountModel(accountSummaryResponse);
            } else {
              setAccountModel(accountSummaryResponse);
            }
          }
        }
      }
    }
    return accountModel;
  }

  getBody(String membershipId) {
    Map txnheader = {
      "transactionID": "",
      "userName": "mob-app",
      "timeStamp": "2020-07-20T10:01:32.131Z"
    };

    Map body = {
      "companyCode": "SA",
      "programCode": "VOYAG",
      "membershipNumber": membershipId,
      "txnHeader": txnheader
    };
    Map head = {"AccountSummaryRequest": body};
    return jsonEncode(head);
  }
}
