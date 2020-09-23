class EnrollmentModel {
  String _title = "MR";
  String _fname;
  String _lastName;
  String _isdCode;
  String _areaCode;
  String _mobile;
  String _email;
  String _dob;
  String _gender;
  String _countryOfResidance;
  String _identityNumber;
  String _passportNumber;
  String _enrollmentDate;
  bool _emailPromotion;
  String _initials;

  String get getTitle => _title;

  set setTitle(String title) {
    _title = title;
  }

  String get getFname => _fname;

  set setFname(String fname) {
    _fname = fname;
  }

  String get getLastName => _lastName;

  set setLastName(String lastName) {
    _lastName = lastName;
  }

  String get getIsdCode => _isdCode;

  set setIsdCode(String isdCode) {
    _isdCode = isdCode;
  }

  String get getAreaCode => _areaCode;

  set setAreaCode(String areaCode) {
    _areaCode = areaCode;
  }

  String get getMobile => _mobile;

  set seMobile(String mobile) {
    _mobile = mobile;
  }

  String get getEmail => _email;

  set setEmail(String email) {
    _email = email;
  }

  String get getDob => _dob;

  set setDob(String dob) {
    _dob = dob;
  }

  String get getGender => _gender;

  set setGender(String gender) {
    _gender = gender;
  }

  String get getCountryOfResidance => _countryOfResidance;

  set setCountryOfResidance(String countryOfResidance) {
    _countryOfResidance = countryOfResidance;
  }

  String get getIdentityNumber => _identityNumber;

  set setIdentityNumber(String identityNumber) {
    _identityNumber = identityNumber;
  }

  String get getPassportNumber => _passportNumber;

  set setPassportNumber(String passportNumber) {
    _passportNumber = passportNumber;
  }

  String get getEnrollmentDate => _enrollmentDate;

  set setEnrollmentDate(String enrollmentDate) {
    _enrollmentDate = enrollmentDate;
  }

  bool get getEmailPromotion => _emailPromotion;

  set setEmailPromotion(bool emailPromotion) {
    _emailPromotion = emailPromotion;
  }

  String get getInitials => _initials;

  set setInitials(String initials) {
    _initials = initials;
  }
}
