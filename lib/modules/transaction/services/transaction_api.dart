import 'dart:convert';

import 'package:api_handler/api_handler.dart';
import 'package:voyager/app_config.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/base/services/helper.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/modules/login/services/response.dart';
import 'package:voyager/modules/transaction/services/transactionList.dart';
import 'package:voyager/modules/transaction/widgets/transaction_history.dart';
import 'package:voyager/services/api_service.dart';

class TransactionsApi {
  final apiHandler = ApiHandler(AppConfig.baseURL);
  ApiResponse response;
  ProfileModel profileModel = LoginUser.profileModel;

  getBody(String fromDate, String toDate) {
    Map loginResponse = json.decode(ApiService.responseObj.getLoginAuth.body);
    String transactionId = loginResponse['AuthenticateMemberResponse']
        ['txnHeader']['transactionID'];

    {
      Map txnheader = {
        "transactionID": "9591CE87C3F220014C408427A4626B75", // transactionId,
        "userName": "mob-app",
        "timeStamp": Helper.getFormatedTime().toString()
      };
      Map activityDetailsRequest = {
        "companyCode": "SA",
        "programCode": "VOYAG",
        "membershipNumber": "500330350", //profileModel.membershipId,
        "activityStatus": "",
        "fromDate": fromDate,
        "toDate": toDate,
        "pageNumber": "1",
        "absoluteIndex": "1",
        "activtyAttributesRequired": "Y",
        "txnHeader": txnheader,
      };
      Map bodyMap = {"ActivityDetailsRequest": activityDetailsRequest};
      var body = jsonEncode(bodyMap);
      return body;
    }
  }

  getActivityDetails(String fromDate, String toDate) async {
    int code = 500;
    print(fromDate);
    var body = getBody(fromDate, toDate);
    String path = AppConfig.activityDetailsURL;
    while (code == 500) {
      response = await apiHandler.requestWith(
        path: "$path",
        type: RequestType.post,
        body: body,
      );
      code = response.code;
    }
    bool status = false;
    if (response != null) {
      if (code == 200) {
        Map responseBody = json.decode(response.body);
        if (response.body.contains("Fault")) {
          Map fault = responseBody['Fault'];
          print('fault');
          TransactionList.error = fault;
          // ChangepinStatus.setErroMsg(fault);
        }
        if (response.body.contains("ActivityDetailsResponse")) {
          Map activityDetailsResponse = responseBody['ActivityDetailsResponse'];
          if (activityDetailsResponse != null) {
            //status = activityDetailsResponse['status'];
            TransactionList.response = activityDetailsResponse;
            TransactionList().setTransactionList();
          }
        }
      }
    }
    return status;
  }
}
