class CharityModel {
//country list model class.

// Version id of model class.
  static final int serialVersionUID = -5381657523046609389;
  // name of the charity.
  String charityName;

  // account number of charity.

  String charityAccNum;
  String get getCharityName => charityName;

  set setCharityName(String charityName) => this.charityName = charityName;

  String get getCharityAccNum => charityAccNum;

  set setCharityAccNum(String charityAccNum) =>
      this.charityAccNum = charityAccNum;

  /**
	 * The model class constructor.
	 * 
	 * @param charityName charity name
	 * @param charityAccNum charity account number
	 */
  CharityModel(String charityName, String charityAccNum) {
    this.charityName = charityName;
    this.charityAccNum = charityAccNum;
  }
}
