class CabinClass {
  String cabinType;
  String code;

  CabinClass(this.cabinType, this.code);

  factory CabinClass.fromJson(dynamic json) {
    return CabinClass(json['cabinType'] as String, json['code'] as String);
  }

  @override
  String toString() {
    return '{ ${this.cabinType}, ${this.code} }';
  }
}
