import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:voyager/base/models/account_model.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/modules/login/services/loginuser.dart';

class QrcodeString {
  ProfileModel profileObject = LoginUser.profileModel;
  AccountModel accountModel = LoginUser.accountModel;
  String airlineTier = "  ";
  String allianceTier = "   ";

  getBarCodeString() {
    setTier();
    String frqflyNumber = fixedLengthString(profileObject.membershipId, 14);
    String lastname = fixedLengthString(profileObject.familyName, 20);
    String firstname = fixedLengthString(profileObject.givenName, 20);
    String paidLoungeIndicator = "N";
    String expdatepaidLoungeIndicator = "      ";
    String variableData = "^";
    String airlineVersionno = "001";
    String cardUniqueNumber = fixedLengthString("", 16);
    String allianceExpdate = getAllianceExpDate();

    String barcodeData = "FFPC" +
        "001" +
        "SA" +
        "00" +
        frqflyNumber +
        lastname +
        firstname +
        allianceTier +
        allianceExpdate +
        airlineTier +
        paidLoungeIndicator +
        expdatepaidLoungeIndicator +
        variableData +
        airlineVersionno +
        cardUniqueNumber;

    return barcodeData;
  }

  fixedLengthString(String string, int length) {
    String finalString;

    if (string.length > length) {
      finalString = string.substring(0, length);
    } else if (string.length < length) {
      finalString = string.padRight(length);
    } else {
      finalString = string;
    }
    return finalString;
  }

  setTier() {
    String tierName = accountModel.getTierName;

    switch (tierName) {
      case "Blue":
        airlineTier = "01";
        allianceTier = "SAS";
        break;
      case "Silver":
        airlineTier = "02";
        allianceTier = "SAS";
        break;
      case "Gold":
        airlineTier = "03";
        allianceTier = "SAG";
        break;
      case "Platinum":
        airlineTier = "04";
        allianceTier = "SAG";
        break;
      case "LifetimePlatinum":
        allianceTier = "SAG";
        airlineTier = "05";
        break;
      default:
        airlineTier = "  ";
        allianceTier = "   ";
        break;
    }
    return airlineTier;
  }

  getFormatedDate(String date) {
    DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
    DateTime parsedStringDate = dateFormat.parse(date);

    String formatedDate = formatDate(parsedStringDate, [mm, yy]).toString();
    return formatedDate;

    //print(formatDate(DateTime(todayDate), [mm, dd]));
  }

  getAllianceExpDate() {
    String date = profileObject.tierToDate;
    String allianceExpdate = "    ";
    print(date);
    if (date != "NA") {
      allianceExpdate = getFormatedDate(date);
    }
    return allianceExpdate;
  }
}
