import 'dart:convert';

import 'package:api_handler/api_handler.dart';
import 'package:voyager/app_config.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/base/services/helper.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/modules/login/services/response.dart';
import 'package:voyager/services/api_service.dart';

class TransactionsApi {
  final apiHandler = ApiHandler(AppConfig.baseURL);
  ApiResponse response;
  ProfileModel profileModel = LoginUser.profileModel;

  getBody() {
    Map loginResponse = json.decode(ApiService.responseObj.getLoginAuth.body);
    String transactionId = loginResponse['AuthenticateMemberResponse']
        ['txnHeader']['transactionID'];

    {
      Map txnheader = {
        "transactionID": transactionId,
        "userName": "mob-app",
        "timeStamp": Helper.getFormatedTime().toString()
      };
      Map activityDetailsRequest = {
        "companyCode": "SA",
        "programCode": "VOYAG",
        "membershipNumber": profileModel.membershipId,
        "activityStatus": "",
        "fromDate": "01-Jan-2019 14:05:10",
        "toDate": "25-May-2019 14:05:10",
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

  getActivityDetails() async {
    int code = 500;

    var body = getBody();
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
          // ChangepinStatus.setErroMsg(fault);
        }
        if (response.body.contains("ActivityDetailsResponse")) {
          Map activityDetailsResponse = responseBody['ActivityDetailsResponse'];
          if (activityDetailsResponse != null) {
            //status = activityDetailsResponse['status'];
            print("success");
          }
        }
      }
    }
    return status;
  }
}
