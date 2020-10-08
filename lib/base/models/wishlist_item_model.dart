class WishlistItemModel {
  String category;
  String awardName;
  String awardPicture;
  String airSearchType;
  String airAwardType;

  WishlistItemModel(String category, String awardName, String awardPicture,
      String airSearchType, String airAwardType) {
    this.category = category;
    this.awardName = awardName;
    this.awardPicture = awardPicture;
    this.airSearchType = airSearchType;
    this.airAwardType = airAwardType;
  }
  String get getCategory => category;

  set setCategory(String category) => this.category = category;

  String get getAwardName => awardName;

  set setAwardName(String awardName) => this.awardName = awardName;

  String get getAwardPicture => awardPicture;

  set setAwardPicture(String awardPicture) => this.awardPicture = awardPicture;

  String get getAirSearchType => airSearchType;

  set setAirSearchType(String airSearchType) =>
      this.airSearchType = airSearchType;

  String get getAirAwardType => airAwardType;

  set setAirAwardType(String airAwardType) => this.airAwardType = airAwardType;
}
