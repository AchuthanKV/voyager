import 'package:api_handler/api_handler.dart';

class Response {
  ApiResponse loginAuth;
  ApiResponse memberProfile;
  ApiResponse accountSummary;
  ApiResponse get getLoginAuth => loginAuth;
  ApiResponse enrollUser;

  ApiResponse get getEnrollUser => enrollUser;

  set setEnrollUser(ApiResponse enrollUser) {
    this.enrollUser = enrollUser;
  }

  set setLoginAuth(ApiResponse loginAuth) => this.loginAuth = loginAuth;

  ApiResponse get getMemberProfile => memberProfile;

  set setMemberProfile(ApiResponse memberProfile) =>
      this.memberProfile = memberProfile;

  ApiResponse get getAccountSummary => accountSummary;

  set setAccountSummary(ApiResponse accountSummary) =>
      this.accountSummary = accountSummary;
}
