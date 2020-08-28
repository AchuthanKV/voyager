import 'package:api_handler/api_handler.dart';

class Response {
  ApiResponse loginAuth;
  ApiResponse memberProfile;
  ApiResponse accountSummary;
  ApiResponse get getLoginAuth => loginAuth;

  set setLoginAuth(ApiResponse loginAuth) => this.loginAuth = loginAuth;

  ApiResponse get getMemberProfile => memberProfile;

  set setMemberProfile(ApiResponse memberProfile) =>
      this.memberProfile = memberProfile;

  ApiResponse get getAccountSummary => accountSummary;

  set setAccountSummary(ApiResponse accountSummary) =>
      this.accountSummary = accountSummary;
}
