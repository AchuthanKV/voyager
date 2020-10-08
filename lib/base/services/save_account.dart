import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:voyager/base/models/account_model.dart';

class SaveGetAccount {
  final _storage = FlutterSecureStorage();
  static AccountModel accountModel;
  saveAccount(AccountModel model) {
    Map modelMap = {
      "membershipNumber": model.membershipNumber,
      "accountStatus": model.accountStatus,
      "points": model.points,
      "tierCode": model.tierCode,
      "title": model.title,
      "tierName": model.tierName,
      "prospectTier": model.prospectTier,
      "tierValidityDate": model.tierValidityDate,
      "pointType": model.pointType,
      "totalPointsAccured": model.totalPointsAccured,
      "pointsToNextTier": model.pointsToNextTier,
      "pointsForTierRetention": model.pointsForTierRetention,
      "tierPoints": model.tierPoints,
      "id": model.id,
    };
    _storage.write(key: 'account', value: jsonEncode(modelMap));
  }

  getAccount() async {
    var data = await _storage.read(key: "account");

    if (data == null) {
      return null;
    } else {
      Map modelMap = jsonDecode(data);
      AccountModel model = new AccountModel();
      model.membershipNumber = modelMap['membershipNumber'];
      model.accountStatus = modelMap['accountStatus'];
      model.points = modelMap['points'];
      model.tierCode = modelMap['tierCode'];
      model.title = modelMap['title'];
      model.tierName = modelMap['tierName'];
      model.prospectTier = modelMap['prospectTier'];
      model.tierValidityDate = modelMap['tierValidityDate'];
      model.pointType = modelMap['pointType'];
      model.totalPointsAccured = modelMap['totalPointsAccured'];
      model.pointsToNextTier = modelMap['pointsToNextTier'];
      model.pointsForTierRetention = modelMap['pointsForTierRetention'];
      model.tierPoints = modelMap['tierPoints'];
      model.id = modelMap['id'];
      SaveGetAccount.accountModel = model;
    }
  }
}
