import 'package:api_handler/api_handler.dart';
import 'package:voyager/app_config.dart';
import 'dart:convert';

import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/base/services/helper.dart';
import 'package:voyager/modules/change_forgot_pin/services/changepin_status.dart';
import 'package:voyager/modules/login/services/loginuser.dart';

class ChangepinApi {
  final apiHandler = ApiHandler(AppConfig.baseURL);
  getBody(String oldPin, String newPin) {
    ProfileModel profileObject = LoginUser.profileModel;
    String scrtQues = profileObject.secretQues;
    if (scrtQues == "NA") {
      scrtQues = "";
    }
    Map txnheader = {
      "transactionID": "",
      "userName": "mob-app",
      "transactionToken": "",
      "timeStamp": Helper.getFormatedTime().toString()
    };

    Map body = {
      "companyCode": "SA",
      "programCode": "VOYAG",
      "membershipNumber": profileObject.membershipId,
      "oldPin": oldPin,
      "newPin": newPin,
      "secretQuestion": scrtQues,
      "txnHeader": txnheader
    };
    Map head = {"ChangeMemberPinRequest": body};
    return jsonEncode(head);
  }

  changePin(String oldPin, String newPin) async {
    int code = 500;
    ApiResponse response;

    var body = getBody(oldPin, newPin);
    String path = AppConfig.changePinURL;
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
      ChangepinStatus.errorMsg = e.description;
      return false;
    } on Exception catch (e) {
      ChangepinStatus.errorMsg =
          "Something Unexpected Occurred. Please try again!!";
      return false;
    }
    bool status = false;
    if (response != null) {
      if (code == 200) {
        Map responseBody = json.decode(response.body);
        if (response.body.contains("Fault")) {
          Map fault = responseBody['Fault'];

          ChangepinStatus.setErroMsg(fault);
        }
        if (response.body.contains("ChangeMemberPinResponse")) {
          Map changeMemberPinResponse = responseBody['ChangeMemberPinResponse'];
          if (changeMemberPinResponse != null) {
            status = changeMemberPinResponse['status'];
          }
        }
      }
    }
    return status;
  }
}
