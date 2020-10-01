class Region {
  String regionOfTravel;
  String origin;
  String destination;

  Region(this.regionOfTravel, this.origin, this.destination);

  factory Region.fromJson(dynamic json) {
    return Region(json['regionOfTravel'] as String, json['origin'] as String,
        json['destination'] as String);
  }

  @override
  String toString() {
    return '{ ${this.regionOfTravel}, ${this.origin}, ${destination} }';
  }
}
