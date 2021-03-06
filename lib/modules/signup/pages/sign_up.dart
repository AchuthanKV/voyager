import 'dart:convert';
import 'dart:core';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voyager/modules/more_about_voyager/pages/about_voyager.dart';
import 'package:voyager/modules/signup/services/enroll_error.dart';
import 'package:voyager/modules/signup/services/enroll_user.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  final _signupFormKey = GlobalKey<FormState>();
  final _signupScaffold = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool isSignUp = false;
  bool signedUp = false;
  bool isEmailOn = false;
  bool isNotificationOn = false;
  bool isSubmitted = false;
  bool isError = false;
  var months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  final TextEditingController initialController = new TextEditingController();
  final TextEditingController countryCodeController =
      new TextEditingController();
  final TextEditingController areaController = new TextEditingController();
  final TextEditingController dobController = new TextEditingController();
  final TextEditingController nationalityController =
      new TextEditingController();
  final TextEditingController titleController = new TextEditingController();

  final TextEditingController genderController = new TextEditingController();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passportController = new TextEditingController();
  final TextEditingController idNumberController = new TextEditingController();

  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _mailFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _passportFocus = FocusNode();
  final FocusNode _idNumberFocus = FocusNode();

  bool isSelected = false;

  String _fName;
  String _lName;
  String _email;
  String _phone;
  String _countryCode = "27";
  String _area;
  String _gender;
  String _title = "Mr";
  String _dobString = "Select date of birth";
  String _nationality;
  String _nationalityCode = "S";
  String _passport;
  String _idNumber;
  List _country_code = [];
  List _nations = [];
  List _nationsCode = [];
  List _genders = ['Male', 'Female'];
  List _titles = [];

  void initState() {
    getTitles();
    _setup();
    getCountries();
    super.initState();
    _area = null;
    emailController.addListener(() {
      final text = emailController.text.toLowerCase();
      emailController.value = emailController.value.copyWith(
        text: text,
        // selection:
        //     TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  void materialPicker() {
    showMaterialSelectionPicker(
      context: context,
      title: "Choose Country Code",
      items: _country_code,
      selectedItem: _countryCode,
      onChanged: (value) => setState(() => _countryCode = value),
    );
  }

  getTitles() async {
    List title = [];
    List<dynamic> tmap =
        await parseJsonFromAssetsTitle('assets/files/titles.json');
    tmap.forEach((element) {
      for (var value in element.values) {
        title.add(firstCharacterUpper(value.toString().toLowerCase()));
      }
    });

    setState(() {
      _titles = title;
    });
  }

  _setup() async {
    // Retrieve the country code (Processed in the background)
    List<String> countryCode = await getCountryCode();

    // Notify the UI and display the country code
    setState(() {
      _country_code = countryCode;
    });
  }

  getCountries() async {
    List country = [];
    List shortCountry = [];
    Map<String, dynamic> dmap =
        await parseJsonFromAssets('assets/files/countries.json');
    dmap["countries"].forEach((element) {
      for (var value in element.values) {
        country.add(firstCharacterUpper(value.toString().toLowerCase()));
      }
    });
    dmap["countries"].forEach((element) {
      for (var key in element.keys) {
        shortCountry.add(firstCharacterUpper(key));
      }
    });

    setState(() {
      _nations = country;
      _nationsCode = shortCountry;
    });
  }

  firstCharacterUpper(String text) {
    List arrayPieces = List();
    String outPut = "";
    text.split(' ').forEach((sepparetedWord) {
      arrayPieces.add(sepparetedWord);
    });

    arrayPieces.forEach((word) {
      if (word[0] != null)
        word =
            "${word[0].toString().toUpperCase()}${word.toString().substring(1)} ";
      outPut += word;
    });

    return outPut;
  }

  Future<List<dynamic>> parseJsonFromAssetsTitle(String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  Future<List<String>> getCountryCode() async {
    List<String> countryCode = [];
    await rootBundle.loadString('assets/files/country_code.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        countryCode.add(i);
      }
    });

    return countryCode;
  }

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  Future<void> go(BuildContext context, Map data) async {
    setState(() {
      _isLoading = true;
    });
    print(data);
    var response = await EnrollUser().enrollUser(data);
    if (response == 'true') {
      print("response true if");
      setState(() {
        _isLoading = false;
        isSignUp = true;
        signedUp = true;
      });
      go1(context);
    } else if (response == null || response == 'fault') {
      print("Error..!!! else if");

      setState(() {
        _isLoading = false;
        signedUp = true;
        isError = true;
      });
      go2(context);
      print("Error..!!!");
    }
  }

  Future<void> go1(BuildContext context) async {
    EnrollmentError.displaySnackBar(_signupScaffold);
    await new Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (Route<dynamic> route) => false);
    setState(() {
      isSignUp = false;
    });
  }

  Future<void> go2(BuildContext context) async {
    EnrollmentError.displaySnackBar(_signupScaffold);
    await new Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => SignUpPage()),
        (Route<dynamic> route) => false);
    setState(() {
      isSignUp = false;
    });
  }

  String getCurrentDate() {
    var now = new DateTime.now();
    var currentDate = "${now.day}-${months[now.month - 1]}-${now.year}";
    return currentDate;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      key: _signupScaffold,
      body: Stack(
        children: [
          BackgroundClass(),
          Container(
            //color: signedUp ? Colors.red : Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              child: _isLoading
                  ? Center(
                      child: SpinKitCubeGrid(
                        color: Colors.black,
                        size: 100.0,
                      ),
                    )
                  : isSignUp
                      ? Stack(children: <Widget>[
                          ListView(
                            children: <Widget>[
                              logoSection(),
                              textSection(),
                              buttonSection(),
                            ],
                          ),
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 5,
                                sigmaY: 5,
                              ),
                              child:
                                  Container(color: Colors.black.withOpacity(0)),
                            ),
                          )
                        ])
                      : ListView(
                          children: <Widget>[
                            logoSection(),
                            textSection(),
                            buttonSection(),
                          ],
                        ),
            ),
          ),
        ],
      ),
      floatingActionButton: isSignUp
          ? Container(
              child: (signedUp && !isError)
                  ? Center(
                      child: Container(
                        width: 500,
                        height: 100,
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[600],
                        ),
                        child: Text(
                          "Successfully enroled. Membership number and your login pin have been sent to your registered email id.",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : !isError
                      ? Container(
                          width: 500,
                          height: 100,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(left: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              "Enrolling New user....",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : null,
            )
          : null,
    );
  }

  Container logoSection() {
    return Container(
      alignment: Alignment(0.0, 0.0),
      height: 75.0,
      //width: 100.0,
      margin: EdgeInsets.only(top: 40.0),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/logo.png'),
        fit: BoxFit.fitHeight,
      )),
    );
  }

  signUpPage(Map data) async {
    isSignUp = true;
    //_storage.write(key: "mail_id", value: emailController.text);
    print("Mail_Id in sign up page :" + emailController.text);
    go(context, data);

    /* SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse;
    var response = await http.post(API.REGISTER_API,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString(
            "accessToken", jsonResponse['results']['user']['accessToken']);
        sharedPreferences.setString(
            "sessionToken", jsonResponse['results']['user']['sessionToken']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      jsonResponse = json.decode(response.body);
      _displaySnackBar(context, jsonResponse);
      print(response.body);
    } */
  }

  Container logoTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(
        "Voyager",
        style: GoogleFonts.raleway(
          textStyle: TextStyle(color: Colors.white, fontSize: 35.0),
        ),
      ),
    );
  }

//Header Section
  Container headerSection() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Sign Up",
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    color: Color(THEME.PRIMARY_COLOR),
                    fontSize: 25.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
            InkWell(
              onTap: () => {
                Navigator.of(context).pop(context),
              },
              child: Text(
                'Go back',
                style: TextStyle(
                    color: Color(THEME.PRIMARY_COLOR),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }

//Text Section with InkWell
  SingleChildScrollView textSection() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Form(
          key: _signupFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Container(
                child: Text(
                  "JOIN VOYAGER",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 30.0),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.grey[300],
                ),
                child: DropdownButtonFormField(
                    validator: (value) {
                      if (_title == null) {
                        return 'Please select Title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) _title = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle, color: Colors.black),
                      hintText: _title,
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    items: _titles.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _title = value;
                      });
                      if (isSubmitted) _signupFormKey.currentState.validate();
                    }),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter First Name';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _fName = value;
                },
                onChanged: (value) {
                  if (isSubmitted) _signupFormKey.currentState.validate();
                },
                controller: firstNameController,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_lastNameFocus);
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle, color: Colors.black),
                  hintText: "First Name",
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                focusNode: _lastNameFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_mailFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Last Name';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _lName = value;
                },
                onChanged: (value) {
                  if (isSubmitted) _signupFormKey.currentState.validate();
                },
                controller: lastNameController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle, color: Colors.black),
                  //Color(THEME.PRIMARY_COLOR)
                  hintText: "Last Name",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (_countryCode.isEmpty) {
                            return 'Please select a Country Code';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          _countryCode = _countryCode.replaceAll(
                              new RegExp(r'[^0-9]'), '');
                        },
                        onChanged: (value) {
                          setState(() {
                            _countryCode = value;
                          });
                          if (isSubmitted)
                            _signupFormKey.currentState.validate();
                        },
                        onTap: () {
                          materialPicker();

                          if (isSubmitted)
                            _signupFormKey.currentState.validate();
                        },
                        controller: countryCodeController,
                        cursorColor: Colors.white70,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(Icons.map, color: Colors.black),
                          hintText: _countryCode.replaceAll(
                              new RegExp(r'[^0-9]'), ''),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintStyle: TextStyle(color: Colors.black),
                          //Color(THEME.PRIMARY_COLOR)
                        ),
                      )),
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a Area Code';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _area = value;
                      },
                      onChanged: (value) {
                        if (isSubmitted) _signupFormKey.currentState.validate();
                      },
                      controller: areaController,
                      cursorColor: Colors.white70,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        icon: Icon(Icons.map, color: Colors.black),
                        hintText: "Area Code",
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintStyle: TextStyle(color: Colors.grey),
                        //Color(THEME.PRIMARY_COLOR)
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a Phone Number';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _phone = value;
                      },
                      onChanged: (value) {
                        if (isSubmitted) _signupFormKey.currentState.validate();
                      },
                      controller: phoneController,
                      cursorColor: Colors.white70,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone, color: Colors.black),
                        hintText: "Phone",
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintStyle: TextStyle(color: Colors.grey),
                        //Color(THEME.PRIMARY_COLOR)
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              TextFormField(
                focusNode: _mailFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_dobFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a Email';
                  } else {
                    Pattern pattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
                    RegExp regex = new RegExp(pattern);
                    if (!(regex.hasMatch(value)))
                      return "Please enter a valid Email";
                  }
                  return null;
                },
                onSaved: (String value) {
                  _email = value;
                },
                onChanged: (value) {
                  if (isSubmitted) _signupFormKey.currentState.validate();
                },
                controller: emailController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(Icons.email, color: Colors.black),
                  hintText: "Email Address",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.grey),
                  //Color(THEME.PRIMARY_COLOR)
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                focusNode: _dobFocus,
                readOnly: true,
                //  onFieldSubmitted: (term) {
                //   FocusScope.of(context).requestFocus(_genderFocus);
                // },
                validator: (value) {
                  if (_dobString == "Select date of birth") {
                    return 'Please select date of Birth';
                  }

                  return null;
                },
                onTap: () async {
                  final datePick = await showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: new DateTime(1900),
                      lastDate: new DateTime.now());
                  if (datePick != null) {
                    setState(() {
                      _dobString =
                          "${datePick.day}-${months[datePick.month - 1]}-${datePick.year}";
                    });
                    if (isSubmitted) _signupFormKey.currentState.validate();
                  }
                },
                onChanged: (value) {
                  setState(() {
                    _dobString = "Date of birth";
                  });
                },
                onSaved: (String value) {},
                controller: dobController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today, color: Colors.black),
                  hintText: _dobString,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 30.0),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.grey[300],
                ),
                child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _gender = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.black),
                      hintText: "Gender",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    items: _genders.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                      if (isSubmitted) _signupFormKey.currentState.validate();
                    }),
              ),
              SizedBox(height: 30.0),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.grey[300],
                ),
                child: DropdownButtonFormField(
                    isExpanded: true,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select Nationality';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _nationality = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      icon: Icon(Icons.language, color: Colors.black),
                      hintText: "Select Nationality",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    items: _nations.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _nationality = value;
                        _nationalityCode =
                            _nationsCode[_nations.indexOf(value)].toString();
                      });
                      print(_nationalityCode);
                      if (isSubmitted) _signupFormKey.currentState.validate();
                    }),
              ),
              SizedBox(height: 30.0),
              (_nationalityCode == "S")
                  ? Container()
                  : (_nationalityCode.trim() == "ZA")
                      ? TextFormField(
                          focusNode: _idNumberFocus,
                          onFieldSubmitted: (term) {
                            FocusScope.of(context).requestFocus(_idNumberFocus);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter ID No.(SA Citizens)';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _idNumber = value;
                          },
                          onChanged: (value) {
                            if (isSubmitted)
                              _signupFormKey.currentState.validate();
                          },
                          controller: idNumberController,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            icon:
                                Icon(Icons.perm_identity, color: Colors.black),
                            //Color(THEME.PRIMARY_COLOR)
                            hintText: "ID No.(SA Citizens)",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        )
                      : TextFormField(
                          focusNode: _passportFocus,
                          onFieldSubmitted: (term) {
                            FocusScope.of(context).requestFocus(_passportFocus);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Passport No.';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _passport = value;
                          },
                          onChanged: (value) {
                            if (isSubmitted)
                              _signupFormKey.currentState.validate();
                          },
                          controller: passportController,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            icon: Icon(Icons.book, color: Colors.black),
                            //Color(THEME.PRIMARY_COLOR)
                            hintText: "Passport No.",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //SizedBox(width: 10),
                  Container(
                    child: Text(
                      'Email me Promotions',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Switch(
                    value: isEmailOn,
                    onChanged: (bool isOn) {
                      setState(() {
                        isEmailOn = isOn;
                      });
                    },
                    activeColor: Colors.green,
                    inactiveTrackColor: Colors.grey[400],
                    inactiveThumbColor: Colors.grey,
                    activeTrackColor: Colors.grey[400],
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //SizedBox(width: 10),
                  Container(
                    child: Text(
                      'Enable my Notification',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Switch(
                    value: isNotificationOn,
                    onChanged: (bool isOn) {
                      setState(() {
                        isNotificationOn = isOn;
                      });
                    },
                    activeColor: Colors.green,
                    inactiveTrackColor: Colors.grey[400],
                    inactiveThumbColor: Colors.grey,
                    activeTrackColor: Colors.grey[400],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container forgotPasswordSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
      alignment: Alignment(1.0, 0.0),
      child: inkWellSection("Forgot Password?"),
    );
  }

  InkWell inkWellSection(String title) {
    return InkWell(
      child: Text(
        title,
        style: TextStyle(
            color: Color(THEME.PRIMARY_COLOR),
            decoration: TextDecoration.underline),
      ),
    );
  }

  Container buttonSection() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            margin: EdgeInsets.only(top: 30.0, bottom: 30),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  isSubmitted = true;
                });
                // Validate returns true if the form is valid, otherwise false.
                if (_signupFormKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  _signupFormKey.currentState.save();
                  print(_fName);
                  Map data = {
                    'title': _title.toUpperCase(),
                    'email': _email,
                    'firstName': _fName,
                    'lastName': _lName,
                    'phone': _phone,
                    'dob': _dobString,
                    'countryCode': _countryCode,
                    'areaCode': _area,
                    'nation': _nationality,
                    'nationCode': _nationalityCode,
                    'gender': _gender.substring(0, 1),
                    'emailOn': isEmailOn,
                    'identityNumber': _idNumber == null ? "" : _idNumber,
                    'passportNumber': _passport == null ? _idNumber : _passport,
                    'enrollmentDate': getCurrentDate(),
                    'initials': _fName.substring(0, 1).toUpperCase()
                  };
                  print(data);
                  signUpPage(data);
                }
              },
              textColor: Colors.white,
              elevation: 0.0,
              color: Color(THEME.BUTTON_COLOR),
              child: Text(
                "SUBMIT",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                    text: "By signing up, I agree to the ",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  TextSpan(
                    text: "Terms of use",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.indigo[900],
                        fontWeight: FontWeight.bold),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DisplaySite(i: 8)));
                      },
                  ),
                  TextSpan(
                    text: " and ",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  TextSpan(
                    text: "Privacy Policy ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.indigo[900],
                        fontWeight: FontWeight.bold),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DisplaySite(i: 9)));
                      },
                  ),
                  TextSpan(
                    text: "of SAA Voyager.",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
