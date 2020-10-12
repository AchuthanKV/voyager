import 'package:api_handler/api_handler.dart';
import 'package:voyager/app_config.dart';
import 'dart:convert';

import 'package:voyager/base/services/helper.dart';
import 'package:voyager/modules/change_forgot_pin/services/forgotpin_status.dart';

class ForgotPinApi {
  final apiHandler = ApiHandler(AppConfig.baseURL);
  getBody(String membershipNum, String emailId) {
    Map txnheader = {
      "transactionID": "",
      "userName": "mob-app",
      "timeStamp": Helper.getFormatedTime().toString()
    };

    Map body = {
      "companyCode": "SA",
      "programCode": "VOYAG",
      "membershipNumber": membershipNum,
      "preferredModeOfCommunication": "E",
      "validationAttribute": [
        {
          "attributeCode": "emailId",
          "attributeValue": emailId,
        },
        {
          "attributeCode": "mobileIsdcode",
          "attributeValue": "",
        },
        {
          "attributeCode": "mobileAreacode",
          "attributeValue": "",
        },
        {
          "attributeCode": "mobileNumber",
          "attributeValue": "",
        }
      ],
      "txnHeader": txnheader
    };
    Map head = {"ResetMemberPinRequest": body};
    return jsonEncode(head);
  }

  forgotPin(String membershipNum, String emailId) async {
    int code = 500;
    ApiResponse response;

    var body = getBody(membershipNum, emailId);
    print(body);
    String path = AppConfig.forgotPinURL;
    try {
      while (code == 500) {
        response = await apiHandler.requestWith(
          path: "$path",
          type: RequestType.post,
          body: body,
        );
        code = response.code;
      }
    } on CommonError catch (e) {
      ForgotPinStatus.errorMsg = e.description;
      return false;
    } on Exception catch (e) {
      ForgotPinStatus.errorMsg =
          "Something unexpected occurred. Please try again !!";
      return false;
    }
    bool status = false;
    if (response != null) {
      if (code == 200) {
        Map responseBody = json.decode(response.body);
        if (response.body.contains("Fault")) {
          Map fault = responseBody['Fault'];
          ForgotPinStatus.setErroMsg(fault);
        }
        if (response.body.contains("ResetMemberPinResponse")) {
          Map resetMemberPinResponse = responseBody['ResetMemberPinResponse'];
          if (resetMemberPinResponse != null) {
            status = resetMemberPinResponse['status']; //true
          }
        }
      }
    }
    return status;
  }
}
