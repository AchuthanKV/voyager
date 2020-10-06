import 'package:voyager/base/models/Transaction_items.dart';
import 'package:voyager/modules/transaction/services/transactionHelper.dart';

class TransactionList {
  static Map response;
  static Map error;

  int totalEnrollmentPoints = 0;
  int totalAccrualPoints = 0;
  int totalRedemptionPoints = 0;
  int totalPurchasePoints = 0;
  int totalTransferPoints = 0;
  int totalMileageAdjustPoints = 0;
  int totalRenewPoints = 0;
  int totalExpirePoints = 0;
  int totalBasePoints = 0;
  int totalStatusPoints = 0;
  String activityImage = "";
  String activityFlagImage = "";
  static String charityName = "  ";
  static List<TransHistoryItems> transList = [];
  List<TransHistoryItems> transHistoryItems = [];

  setTransactionList() {
    if (response.containsKey('activityDetails')) {
      if (response['activityDetails'] is List) {
        List activityDetails = response['activityDetails'];

        for (int i = 0; i < activityDetails.length; i++) {
          Map activity = activityDetails[i];
          TransHistoryItems item = setListItem(activity);
          if (item != null) {
            transHistoryItems.add(item);
          }
        }
      } else if (response['activityDetails'] is Map) {
        TransHistoryItems item = setListItem(response['activityDetails']);
        if (item != null) {
          transHistoryItems.add(item);
        }
      }
    }
    print(transHistoryItems.length);
    transList = transHistoryItems;
    return transHistoryItems;
  }

  setListItem(Map activity) {
    String activityName = activity['activityType'];

    String actualDescription = activity['activityDescription'];
    String activityDate = activity['activityDate'];
    List points = activity['pointDetails'];
    int totalPoints = getTotalPoints(points);
    String extractedDesc =
        getExtractedActivityDesc(activityName, actualDescription, points);

    switch (activityName) {
      case "Member Enrollment":
        activityImage = "enrollment.png";
        activityFlagImage = "enrollment_flag.png";
        if (totalPoints != 0) {
          return new TransHistoryItems(activityImage, activityFlagImage,
              activityName, extractedDesc, activityDate, totalPoints);
        }

        break;
      case "Accrual":
        activityImage = "acural.png";
        activityFlagImage = "redemption_flag.png";
        return new TransHistoryItems(activityImage, activityFlagImage,
            activityName, extractedDesc, activityDate, totalPoints);
        break;
      case "Redemption":
        activityImage = "redemption.png";
        activityFlagImage = "acural_flag.png";
        return new TransHistoryItems(activityImage, activityFlagImage,
            activityName, extractedDesc, activityDate, totalPoints);
        break;
      case "Purchase of Miles":
        activityImage = "purchasepoints.png";
        activityFlagImage = "purchasepoints_flag.png";
        return new TransHistoryItems(activityImage, activityFlagImage,
            activityName, extractedDesc, activityDate, totalPoints);
        break;
      case "Donation of Miles":
        activityImage = "transferpoints.png";
        activityFlagImage = "transferpoints_flag.png";
        activityName = "Transfer Miles";
        return new TransHistoryItems(activityImage, activityFlagImage,
            activityName, extractedDesc, activityDate, totalPoints);
        break;
      case "Mileage Adjustments":
        activityImage = "mileage.png";
        activityFlagImage = "mileage_flag.png";
        return new TransHistoryItems(activityImage, activityFlagImage,
            activityName, extractedDesc, activityDate, totalPoints);
        break;
      case "Extended Miles Expiry":
        activityImage = "expirypoints.png";
        activityFlagImage = "expirypoints_flag.png";
        return new TransHistoryItems(activityImage, activityFlagImage,
            activityName, extractedDesc, activityDate, totalPoints);
        break;
      case "Expiry of Miles":
        if ("Totals for the previous year have been Reset" !=
            actualDescription) {
          activityImage = "expirypoints.png";
          activityFlagImage = "expirypoints_flag.png";
          return new TransHistoryItems(activityImage, activityFlagImage,
              activityName, extractedDesc, activityDate, totalPoints);
        }

        //  toggleMailIgetExtractedActivityDesccon();

        points.forEach((element) {
          String pointType = element['pointType'];
          if (equalsIgnoreCase(pointType, "BASE")) {
            totalBasePoints += element['points'];
          } else if (equalsIgnoreCase(pointType, "BASE")) {
            totalStatusPoints += element['points'];
          }
        });
    }

    return null;
  }

  bool equalsIgnoreCase(String a, String b) {
    if (a.toLowerCase() == b.toLowerCase()) {
      return true;
    }
    return false;
  }

  int find_str(String main, String search) {
    int i;
    int found = -1;

    List<String> s = main.split(" ");

    for (i = 0; i < s.length; i++) {
      if (search == s[i]) {
        found = i + 1;
      }
    }
    return found;
  }

  getExtractedActivityDesc(
      String activityName, String actualDesc, List points) {
    String extractedDes = "";

    int totalPoint = 0;
    switch (activityName) {
      case "Member Enrollment":
        points.forEach((element) {
          totalPoint += element['points'];
          extractedDes = "Enrolled with " + totalPoint.toString();
          // to get total Member Enrollment Points
          totalEnrollmentPoints += totalPoint;
        });
        break;
      case "Accrual":
        int firstIndex = actualDesc.indexOf("-");
        String subStr1 = actualDesc.substring(0, firstIndex - 1);

        int text = find_str(subStr1, "Activity");

        if (text == -1) {
          extractedDes = "Earned for " + subStr1;
        } else {
          int activityIndex = subStr1.indexOf("Activity");
          String txt = subStr1.substring(0, activityIndex - 1);
          extractedDes = "Earned  on  " + txt;
        }
        points.forEach((element) {
          String pointType = element['PointType'];

          if (!equalsIgnoreCase("ERKTCNT", pointType)) {
            totalPoint += element['points'];
          }
        });

        totalAccrualPoints += totalPoint;
        break;
      case "Redemption":
        List<String> redemptionArray = actualDesc.split(" ");
        int index = redemptionArray.indexOf("Partner");

        String txt = redemptionArray[index + 1];

        extractedDes = "Redeemed on " + txt;

        // to get total Redemption points
        points.forEach((element) {
          totalPoint += element['points'];
        });

        totalRedemptionPoints += totalPoint;
        break;
      case "Purchase of Miles":
        List<String> purchaseArray = actualDesc.split(" ");

        extractedDes = purchaseArray[1];

        // to get total Purchase points
        points.forEach((element) {
          totalPoint += element['points'];
        });

        totalPurchasePoints += totalPoint;
        break;
      case "Donation of Miles":
        String txt = actualDesc.replaceAll(new RegExp(r'[^0-9]'), '');

        TransactionHelper().getCharityNameFromCharityNumber(txt);

        extractedDes = "Transferred miles to " + TransactionList.charityName;

        points.forEach((element) {
          totalPoint += element['points'];
        });

        totalTransferPoints += totalPoint;
        break;

      case "Mileage Adjustments":
        List<String> mileageArray = actualDesc.split(",");

        if (mileageArray.length == 1) {
          extractedDes = "Credited to MEM";
        } else {
          String txt1 = mileageArray[0].replaceAll(new RegExp(r'[^0-9]'), '');
          String txt2 = mileageArray[1].replaceAll(new RegExp(r'[^0-9]'), '');

          int val1 = int.parse(txt1);
          int val2 = int.parse(txt2);

          if ((val1 + val2) > 0) {
            extractedDes = "Credited to MEM";
          } else {
            extractedDes = "Debited from MEM";
          }
        }

        // to get total Donation of Miles

        points.forEach((element) {
          totalPoint += element['points'];
        });
        totalMileageAdjustPoints += totalPoint;
        break;
      case "Extended Miles Expiry":
        List<String> milesExpiry = actualDesc.split(" ");
        extractedDes = milesExpiry[0];

        // to get total Donation of Miles

        points.forEach((element) {
          totalPoint += element['points'];
        });

        totalRenewPoints += totalPoint;
        break;
      case "Expiry of Miles":
        if ("Totals for the previous year have been Reset" != actualDesc) {
          extractedDes = actualDesc;
          // to get total Donation of Miles

          points.forEach((element) {
            totalPoint += element['points'];
          });

          totalExpirePoints += totalPoint;
        }
    }

    return extractedDes;
  }

  getTotalPoints(List points) {
    int totalPoint = 0;
    points.forEach((element) {
      String pointType = element['pointType'];

      /* TO calculate total miles for each transaction*/
      if (equalsIgnoreCase(pointType, "BONUS")) {
        totalPoint += element['points'];
      }
      if (equalsIgnoreCase(pointType, "BASE")) {
        totalPoint += element['points'];
      }
      if (equalsIgnoreCase(pointType, "PURCH")) {
        totalPoint += element['points'];
      }
      if (equalsIgnoreCase(pointType, "MNREINST")) {
        totalPoint += element['points'];
      }
      if (equalsIgnoreCase(pointType, "MNBONEXP")) {
        totalPoint += element['points'];
      }
      if (equalsIgnoreCase(pointType, "REINST")) {
        totalPoint += element['points'];
      }
      if (equalsIgnoreCase(pointType, "RFBON01")) {
        totalPoint += element['points'];
      }
      if (equalsIgnoreCase(pointType, "RFBON02")) {
        totalPoint += element['points'];
      }
      if (equalsIgnoreCase(pointType, "RFBON03")) {
        totalPoint += element['points'];
      }
      if (equalsIgnoreCase(pointType, "MPURCH")) {
        totalPoint += element['points'];
      }
      if (equalsIgnoreCase(pointType, "1YRBON")) {
        totalPoint += element['points'];
      }
      if (equalsIgnoreCase(pointType, "6MBON")) {
        totalPoint += element['points'];
      }

      if (equalsIgnoreCase(pointType, "3MBON")) {
        totalPoint += element['points'];
      }
    });

    return totalPoint;
  }
}
