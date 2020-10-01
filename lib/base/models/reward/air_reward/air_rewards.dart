import 'package:voyager/base/models/reward/air_reward/saa_award.dart';
import 'package:voyager/base/models/reward/air_reward/star_alliance_awards.dart';

class AirRewards {
  List<SaaAward> saaAwards;
  StarAllianceAwards starAllianceAwards;

  AirRewards([this.saaAwards, this.starAllianceAwards]);

  factory AirRewards.fromJson(dynamic json) {
    List<SaaAward> saaAwards;
    if (json['airRewards']['saaAwards'] != null) {
      var saaAwardObjsJson = json['airRewards']['saaAwards'] as List;
      saaAwards = saaAwardObjsJson.map((saaAward) =>
          SaaAward.fromJson(saaAward)).toList();
    }

    return AirRewards(
      saaAwards,
      StarAllianceAwards.fromJson(json['airRewards']['starAllianceAwards']),
    );
  }

  @override
  String toString() {
    return '{ ${this.saaAwards}, ${this.starAllianceAwards} }';
  }
}