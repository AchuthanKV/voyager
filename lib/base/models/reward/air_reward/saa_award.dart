import 'package:voyager/base/models/reward/air_reward/region.dart';

import 'award.dart';
import 'award_type.dart';
import 'cabin_class.dart';

class SaaAward {
  List<Award> awards;
  List<AwardType> awardTypes;
  List<String> searchType;
  List<Region> regions;
  List<CabinClass> cabinClass;

  SaaAward(
      [this.awards,
      this.awardTypes,
      this.searchType,
      this.regions,
      this.cabinClass]);

  // ignore: missing_return
  factory SaaAward.fromJson(dynamic json) {
    List<Award> awards;
    List<AwardType> awardTypes;
    List<String> searchTypes;
    List<Region> regionList;
    List<CabinClass> cabinClassList;

    if (json['awards'] != null) {
      var awardObjsJson = json['awards'] as List;
      awards = awardObjsJson.map((award) => Award.fromJson(award)).toList();
    }

    if (json['awardTypes'] != null) {
      var awardTypeObjJson = json['awardTypes'] as List;
      awardTypes = awardTypeObjJson
          .map((awardType) => AwardType.fromJson(awardType))
          .toList();
    }
    if (json['searchType'] != null) {
      //searchTypes = json['searchType'] as List;
      var searchTypeList = json['searchType'] as List;
      searchTypes = List<String>();
      searchTypeList.forEach((element) {
        if(element != null){
          print(element);
          searchTypes.add(element.toString());
          print('search Types$searchTypes');
        }
      });
    }
    if (json['regions'] != null) {
      var regionObjJson = json['regions'] as List;
      regionList =
          regionObjJson.map((region) => Region.fromJson(region)).toList();
    }
    if (json['cabinClass'] != null) {
      var cabinObjJson = json['cabinClass'] as List;
      cabinClassList =
          cabinObjJson.map((cabin) => CabinClass.fromJson(cabin)).toList();
    }

    return SaaAward(
        awards, awardTypes, searchTypes, regionList, cabinClassList);
  }

  @override
  String toString() {
    return '{ ${this.awards}, ${this.awardTypes}, ${this.searchType}, ${this.regions}, ${this.cabinClass} }';
  }
}
