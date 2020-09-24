class TransHistoryItems {
  /**
    * activity Image.
    */
  int activityImage;
  /**
    * flag of activity Image.
    */
  int activityImageFlag;
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

  int get getActivityImage => activityImage;

  set setActivityImage(int activityImage) => this.activityImage = activityImage;

  int get getActivityImageFlag => activityImageFlag;

  set setActivityImageFlag(int activityImageFlag) =>
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
      int activityImage,
      int activityImageFlag,
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
