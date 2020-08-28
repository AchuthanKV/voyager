import 'dart:convert';

import 'package:api_handler/api_handler.dart';
import 'package:voyager/app_config.dart';
import 'package:voyager/modules/login/services/response.dart';

class ApiService {
  final apiHandler = ApiHandler(AppConfig.baseURL);

  Future<String> userStatus(String path, body) async {
    ApiResponse response = await apiHandler.requestWith(
      path: "$path",
      type: RequestType.post,
      body: body,
    );

    if (response != null) {
      int code = response.code;

      if (code == 200) {
        Response().setLoginAuth = response;
        Map res = json.decode(response.body);
        if (response.body.contains("AuthenticateMemberResponse")) {
          Map member = res['AuthenticateMemberResponse'];

          if (member['status'] == true) {
            return 'true';
          }
        } else if (response.body.contains('Fault')) {
          Map member = res['Fault'];
          return 'false';
        }
      } else if (code == 500) {
        return 'connectionRefused';
      }
    }
  }
}
