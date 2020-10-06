import 'package:voyager/base/models/profile_model.dart';

class AccountModel {
  String membershipNumber;

// Variable to store account status.
  String accountStatus;

//Variable to store points.
  String points;

//Variable to store tier code.
  String tierCode;

//Variable to store title.
  String title;

// Variable to store tier name.
  String tierName;

//Variable to store prospect tier.
  String prospectTier;

  //Variable to store tier validity date.
  String tierValidityDate;

//Variable to store point type.
  String pointType;

  //Variable to store total accrued points.
  String totalPointsAccured;

  // Variable to store points needed to reach next tier.
  String pointsToNextTier;

  //Variable to store points to retain tier.
  String pointsForTierRetention;

  //Variable to store tier points.
  String tierPoints;

  String id;
  String get getMembershipNumber => membershipNumber;

  set setMembershipNumber(String membershipNumber) =>
      this.membershipNumber = membershipNumber;

  String get getAccountStatus => accountStatus;

  set setAccountStatus(String accountStatus) =>
      this.accountStatus = accountStatus;

  String get getPoints => points;

  set setPoints(String points) => this.points = points;

  String get getTierCode => tierCode;

  set setTierCode(String tierCode) => this.tierCode = tierCode;

  String get getTitle => title;

  set setTitle(String title) => this.title = title;

  String get getTierName => tierName;

  set setTierName(String tierName) => this.tierName = tierName;

  String get getProspectTier => prospectTier;

  set setProspectTier(String prospectTier) => this.prospectTier = prospectTier;

  String get getTierValidityDate => tierValidityDate;

  set setTierValidityDate(String tierValidityDate) =>
      this.tierValidityDate = tierValidityDate;

  String get getPointType => pointType;

  set setPointType(String pointType) => this.pointType = pointType;

  String get getTotalPointsAccured => totalPointsAccured;

  set setTotalPointsAccured(String totalPointsAccured) =>
      this.totalPointsAccured = totalPointsAccured;

  String get getPointsToNextTier => pointsToNextTier;

  set setPointsToNextTier(String pointsToNextTier) =>
      this.pointsToNextTier = pointsToNextTier;

  String get getPointsForTierRetention => pointsForTierRetention;

  set setPointsForTierRetention(String pointsForTierRetention) =>
      this.pointsForTierRetention = pointsForTierRetention;

  String get getTierPoints => tierPoints;

  set setTierPoints(String tierPoints) => this.tierPoints = tierPoints;

  String get getId => id;

  set setId(String id) => this.id = id;

// AccountModel(String membershipNumber, String accountStatus,
//       String points, String tierCode, String title, String tierName,
//       String prospectTier, String tierValidityDate, String pointType,
//       String totalPointsAccured, String pointsToNextTier,
//       String pointsForTierRetention, String tierPoints, int id) {

//    this.membershipNumber = membershipNumber;
//    this.accountStatus = accountStatus;
//    this.points = points;
//    this.tierCode = tierCode;
//    this.title = title;
//    this.tierName = tierName;
//    this.prospectTier = prospectTier;
//    this.tierValidityDate = tierValidityDate;  // tierToDate
//    this.pointType = pointType;
//    this.totalPointsAccured = totalPointsAccured;
//    this.pointsToNextTier = pointsToNextTier;
//    this.pointsForTierRetention = pointsForTierRetention;
//    this.tierPoints = tierPoints;
//    this.id = id;

// }

}
