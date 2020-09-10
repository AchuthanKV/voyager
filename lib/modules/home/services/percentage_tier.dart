import 'package:voyager/base/models/account_model.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/modules/login/services/loginuser.dart';

class Tierpercentage {
  ProfileModel profileObject = LoginUser.profileModel;
  AccountModel accountModel = LoginUser.accountModel;

  int percentageRetention;
  double completedPercentage;
  double remainingPercentage;

  go() {
    String tierName = accountModel.getTierName;
    tierName = tierName.toLowerCase();

    if (tierName == 'blue') {
      percentageRetention = getPercentageTier(
          accountModel.getTierPoints, accountModel.getPointsToNextTier);

      completedPercentage = percentageRetention / 10;
      remainingPercentage = (10 - completedPercentage);
    } else {
      double retainPoints =
          double.parse(accountModel.getPointsForTierRetention);
      print(retainPoints);
      if (retainPoints == 0.0) {
        percentageRetention = 100;
      } else {
        percentageRetention =
            getPercentageTier(accountModel.getPoints, retainPoints);
      }
      completedPercentage = percentageRetention / 10;
      remainingPercentage = (10 - completedPercentage);
    }
    completedPercentage = completedPercentage / 10;
    print(completedPercentage);
    return completedPercentage;
  }

  getPercentageTier(pointsAccured, pointsToNextTier) {
    int percentageProspectTierValue = 0;
    double accuredPoints = double.parse(pointsAccured);
    double nextTierPoints = double.parse(pointsToNextTier);
    if (accuredPoints != 0 && nextTierPoints != 0 /*&& !(nextTierPoints <0)*/) {
      percentageProspectTierValue =
          (accuredPoints * 100 / (nextTierPoints + accuredPoints)).round();
    }
    return percentageProspectTierValue;
  }
}
