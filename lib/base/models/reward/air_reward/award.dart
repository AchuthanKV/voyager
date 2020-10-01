class Award {
  String awardName;
  String code;

  Award(this.awardName, this.code);

  factory Award.fromJson(dynamic json) {
    return Award(json['awardName'] as String, json['code'] as String);
  }

  @override
  String toString() {
    return '{ ${this.awardName}, ${this.code} }';
  }
}
