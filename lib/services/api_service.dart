import 'dart:convert';

import 'package:api_handler/api_handler.dart';
import 'package:voyager/app_config.dart';
import 'package:voyager/modules/login/services/response.dart';
import 'package:voyager/modules/login/widgets/login_error.dart';

class ApiService {
  final apiHandler = ApiHandler(AppConfig.baseURL);
  static Response responseObj;

  Future<String> userStatus(String path, body) async {
    ApiResponse response;
    Response respObj = Response();
    responseObj = respObj;
    response = await apiHandler.requestWith(
      path: "$path",
      type: RequestType.post,
      body: body,
    );

    if (response != null) {
      int code = response.code;

      if (code == 200) {
        respObj.setLoginAuth = response;
        Map res = json.decode(response.body);
        if (response.body.contains("AuthenticateMemberResponse")) {
          Map member = res['AuthenticateMemberResponse'];

          if (member['status'] == true) {
            return 'true';
          }
        } else if (response.body.contains('Fault')) {
          print("FaultFaultFault");
          LoginErrorAlert.setError(respObj);
          return 'fault';
        }
      } else if (code == 500) {
        return 'connectionRefused';
      }
    }
  }
}
