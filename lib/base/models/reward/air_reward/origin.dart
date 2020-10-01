class Origin {
  String region;
  String code;

  Origin(this.region, this.code);

  factory Origin.fromJson(dynamic json) {
    print(json);
    if (json != null) {
      print('In Origin Section');
      print(json['region']);
      return Origin(
          json['region'] as String, json['code'] as String);
    }
  }

  @override
  String toString() {
    return '{ ${this.region}, ${this.code} }';
  }
}
