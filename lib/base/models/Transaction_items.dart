class TransHistoryItems {
  /**
    * activity Image.
    */
  String activityImage;
  /**
    * flag of activity Image.
    */
  String activityImageFlag;
  /**
    * activity name.
    */
  String activityName;
  /**
    * activity Description.
    */
  String activityDescription;
  /**
    * activity Date.
    */
  String activityDate;
  /**
    * activity Points.
    */
  int activityPoints;

  String get getActivityImage => activityImage;

  set setActivityImage(String activityImage) =>
      this.activityImage = activityImage;

  String get getActivityImageFlag => activityImageFlag;

  set setActivityImageFlag(String activityImageFlag) =>
      this.activityImageFlag = activityImageFlag;

  String get getActivityName => activityName;

  set setActivityName(String activityName) => this.activityName = activityName;

  String get getActivityDescription => activityDescription;

  set setActivityDescription(String activityDescription) =>
      this.activityDescription = activityDescription;

  int get getActivityPoints => activityPoints;

  set setActivityPoints(int activityPoints) =>
      this.activityPoints = activityPoints;

  /**
    * constructor
    */
  TransHistoryItems(
      String activityImage,
      String activityImageFlag,
      String activityName,
      String activityDescription,
      String activityDate,
      int activityPoints) {
    this.activityImage = activityImage;
    this.activityImageFlag = activityImageFlag;
    this.activityName = activityName;
    this.activityDescription = activityDescription;
    this.activityDate = activityDate;
    this.activityPoints = activityPoints;
  }
}
