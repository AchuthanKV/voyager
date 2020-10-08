import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/modules/more_about_voyager/pages/about_url.dart';

class SaveGetProfile {
  final _storage = FlutterSecureStorage();
  static ProfileModel profileModel;
  saveProfile(ProfileModel model) {
    Map modelMap = {
      "membershipId": model.membershipId,
      "accountStatus": model.accountStatus,
      "enrolmentSource": model.enrolmentSource,
      "enrollmentSourceCode": model.enrollmentSourceCode,
      "enrolmentDate": model.enrolmentDate,
      "periodType": model.periodType,
      "period": model.period,
      "extendToDay": model.extendToDay,
      "extendToMonth": model.extendToMonth,
      "tier": model.tier,
      "tierFromDate": model.tierFromDate,
      "tierToDate": model.tierToDate,
      "tierColor": model.tierColor,
      "tierName": model.tierName,
      "nextTierName": model.nextTierName,
      "customerNumber": model.customerNumber,
      "membershipType": model.membershipType,
      "membershipStatus": model.membershipStatus,
      "secretQues": model.secretQues,
      "secretAns": model.secretAns,
      "title": model.title,
      "memberNationality": model.memberNationality,
      "givenName": model.givenName,
      "familyName": model.familyName,
      "initials": model.initials,
      "gender": model.gender,
      "maritalStatus": model.maritalStatus,
      "dateOfBirth": model.dateOfBirth,
      "passportNumber": model.passportNumber,
      "idNumber": model.idNumber,
      "companyName": model.companyName,
      "preferredLanguage": model.preferredLanguage,
      "preferredAddress": model.preferredAddress,
      "addressType": model.addressType,
      "addressLine1": model.addressLine1,
      "addressLine2": model.addressLine2,
      "city": model.city,
      "state": model.state,
      "country": model.country,
      "zipCode": model.zipCode,
      "emailAddress": model.emailAddress,
      "phoneISDCode": model.phoneISDCode,
      "phoneAreaCode": model.phoneAreaCode,
      "phoneNumber": model.phoneNumber,
      "mobileISDCode": model.mobileISDCode,
      "mobileAreaCode": model.mobileAreaCode,
      "mobileNumber": model.mobileNumber,
      "faxISDCode": model.faxISDCode,
      "faxAreaCode": model.faxAreaCode,
      "fax": model.fax,
      "skypeID": model.skypeID,
    };
    _storage.write(key: 'profile', value: jsonEncode(modelMap));
    print("saved profile");
  }

  getProfile() async {
    var data = await _storage.read(key: "profile");

    if (data != null) {
      Map modelMap = jsonDecode(data);
      ProfileModel model = new ProfileModel();
      model.membershipId = modelMap['membershipId'];
      model.accountStatus = modelMap['accountStatus'];
      model.enrolmentSource = modelMap['enrolmentSource'];
      model.enrollmentSourceCode = modelMap['enrollmentSourceCode'];
      model.enrolmentDate = modelMap['enrolmentDate'];
      model.periodType = modelMap['periodType'];
      model.period = modelMap['period'];
      model.extendToDay = modelMap['extendToDay'];
      model.extendToMonth = modelMap['extendToMonth'];
      model.tier = modelMap['tier'];
      model.tierFromDate = modelMap['tierFromDate'];
      model.tierToDate = modelMap['tierToDate'];
      model.tierColor = modelMap['tierColor'];
      model.tierName = modelMap['tierName'];
      model.nextTierName = modelMap['nextTierName'];

      model.customerNumber = modelMap['customerNumber'];
      model.membershipType = modelMap['membershipType'];
      model.membershipStatus = modelMap['membershipStatus'];
      model.secretQues = modelMap['secretQues'];
      model.secretAns = modelMap['secretAns'];

      model.title = modelMap['title'];
      model.memberNationality = modelMap['memberNationality'];
      model.givenName = modelMap['givenName'];
      model.familyName = modelMap['familyName'];
      model.initials = modelMap['initials'];
      model.gender = modelMap['gender'];
      model.maritalStatus = modelMap['maritalStatus'];
      model.dateOfBirth = modelMap['dateOfBirth'];
      model.passportNumber = modelMap['passportNumber'];
      model.idNumber = modelMap['idNumber'];
      model.companyName = modelMap['companyName'];
      model.preferredLanguage = modelMap['preferredLanguage'];
      model.preferredAddress = modelMap['preferredAddress'];

      model.addressType = modelMap['addressType'];
      model.addressLine1 = modelMap['addressLine1'];
      model.addressLine2 = modelMap['addressLine2'];
      model.city = modelMap['city'];
      model.state = modelMap['state'];
      model.country = modelMap['country'];
      model.zipCode = modelMap['zipCode'];
      model.emailAddress = modelMap['emailAddress'];
      model.phoneISDCode = modelMap['phoneISDCode'];
      model.phoneAreaCode = modelMap['phoneAreaCode'];
      model.phoneNumber = modelMap['phoneNumber'];
      model.mobileISDCode = modelMap['mobileISDCode'];
      model.mobileAreaCode = modelMap['mobileAreaCode'];
      model.mobileNumber = modelMap['mobileNumber'];
      model.faxISDCode = modelMap['faxISDCode'];
      model.faxAreaCode = modelMap['faxAreaCode'];
      model.fax = modelMap['fax'];
      model.skypeID = modelMap['skypeID'];
      SaveGetProfile.profileModel = model;
    } else {
      return null;
    }
  }
}
