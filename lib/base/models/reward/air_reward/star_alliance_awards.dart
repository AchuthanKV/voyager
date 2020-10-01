import 'award.dart';
import 'cabin_class.dart';
import 'destination.dart';
import 'origin.dart';

class StarAllianceAwards {
  List<Award> awards;
  List<String> searchType;
  List<Origin> origin;
  List<Destination> destination;
  List<CabinClass> cabinClass;

  StarAllianceAwards(this.awards, this.searchType, this.origin,
      this.destination, this.cabinClass);

  factory StarAllianceAwards.fromJson(dynamic json) {
    List<Award> awardList;
    List<String> searchTypes;
    List<Origin> originList;
    List<Destination> destinationList;
    List<CabinClass> cabinClassList;
    if (json['awards'] != null) {
      var awardObjsJson = json['awards'] as List;
      awardList = awardObjsJson.map((award) => Award.fromJson(award)).toList();
    }
    if (json['searchType'] != null) {
      var searchTypeList = json['searchType'] as List;
      searchTypes = List<String>();
     searchTypeList.forEach((element) {
       if(element != null){
         print(element);
         searchTypes.add(element.toString());
         print('search Types$searchTypes');
       }
     });
     // print(searchTypeList);
      //searchTypes.addAll(searchTypeList.getRange(0, searchTypeList.length));
      print(searchTypes);
    }
    if (json['origin'] != null) {
      var originObjJson = json['origin'] as List;
      originList =
          originObjJson.map((origin) => Origin.fromJson(origin)).toList();
    }
    if (json['destination'] != null) {
      var destinationObjJson = json['destination'] as List;
      destinationList = destinationObjJson
          .map((destination) => Destination.fromJson(destination))
          .toList();
    }
    if (json['cabinClass'] != null) {
      var cabinObjJson = json['cabinClass'] as List;
      cabinClassList =
          cabinObjJson.map((cabin) => CabinClass.fromJson(cabin)).toList();
    }
    return StarAllianceAwards(
        awardList, searchTypes, originList, destinationList, cabinClassList);
  }

  @override
  String toString() {
    return '{ ${this.awards}, ${this.searchType}, ${this.origin}, ${this.destination}, ${this.cabinClass} }';
  }
}
