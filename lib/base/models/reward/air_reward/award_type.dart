class AwardType {
  String awardName;
  String code;

  AwardType(this.awardName, this.code);

  factory AwardType.fromJson(dynamic json) {
    return AwardType(json['awardName'] as String, json['code'] as String);
  }

  @override
  String toString() {
    return '{ ${this.awardName}, ${this.code} }';
  }
}
