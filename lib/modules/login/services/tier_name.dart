import 'package:flutter/material.dart';
import 'package:voyager/theme/theme.dart' as THEME;
import 'package:voyager/base/utils/tierpoints.dart';

class TierName {
  String extractedTier;
  int tierColor;
  getTierName(int tier) {
    switch (tier) {
      case TierPoints.HUNDRED:
      case TierPoints.ONEFOURTYFOUR:
      case TierPoints.ONEFIFTYFIVE:
      case TierPoints.ONESIXTYFIVE:
        extractedTier = "Blue";
        /* customer said to put Blue instead of Base */
        break;
      case TierPoints.TWOHUNDRED:
      case TierPoints.TWOFOURTYFOUR:
      case TierPoints.TWOFIFTYFIVE:
      case TierPoints.TWOSIXTYFIVE:
        extractedTier = "Blue";
        /*
       * customer said to put Blue instead of BaseOne
       */
        break;
      case TierPoints.THREEHUNDRED:
      case TierPoints.THREEFOURTYFOUR:
      case TierPoints.THREEFIFTYFIVE:
      case TierPoints.THREESIXTYFIVE:
        extractedTier = "Blue";
        break;
      case TierPoints.FOURNOTEFOUR:
      case TierPoints.FOURFIFTYFIVE:
      case TierPoints.FOURSIXTYFIVE:
        extractedTier = "Silver";
        break;
      case TierPoints.FIVENOTEFIVE:
      case TierPoints.FIVESIXTYFIVE:
        extractedTier = "Gold";
        break;
      case TierPoints.SIXNOTEFIVE:
        extractedTier = "Platinum";
        break;
      case TierPoints.SEVENNOTEFIVE:
        extractedTier = "LifetimePlatinum";
        break;
      default:
        extractedTier = "NA";
        break;
    }
    return extractedTier;
  }

  getTierColor(int tier) {
    String tierName = getTierName(tier);
    switch (tierName) {
      case "Blue":
        tierColor = THEME.TIER_BLUE;
        break;
      case "Silver":
        tierColor = THEME.TIER_SILVER;
        break;
      case "Gold":
        tierColor = THEME.TIER_GOLD;
        break;
      case "Platinum":
        tierColor = THEME.TIER_PLATINUM;
        break;
      case "LifetimePlatinum":
        tierColor = THEME.TIER_LIFETIMEPLATINUM;
        break;
      default:
        tierColor = THEME.WHITE_COLOR;
        break;
    }
    return tierColor;
  }
}
