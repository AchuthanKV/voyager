class Destination {
  String region;
  String code;

  Destination(this.region, this.code);

  factory Destination.fromJson(dynamic json) {
    return Destination(json['region'] as String,
        json['code'] as String);
  }

  @override
  String toString() {
    return '{ ${this.region}, ${this.code} }';
  }
}
