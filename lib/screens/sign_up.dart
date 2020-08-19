import 'dart:convert';
import 'dart:core';
import 'dart:ui';
import 'package:voyager/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyager/services/api.dart' as API;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:voyager/theme/theme.dart' as THEME;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:voyager/screens/login_page.dart';

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

  final TextEditingController initialController = new TextEditingController();
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

  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _mailFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();

  String _fName;
  String _lName;
  String _email;
  String _phone;
  String _area;
  String _gender;
  String _dobString = "Select date of birth";
  String _nationality;
  List _locations = ['+91', '72'];
  List _nations = ['India', 'USA', 'China'];
  List _genders = ['Male', 'Female', 'Other'];
  List _title = ['Mr', 'Miss', 'Mrs', 'Ms', 'Major'];

  void initState() {
    super.initState();
    getAreaCode();
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

  getAreaCode() async {
    //http.Response response = await http.get('http://country.io/phone.json');
    // Map code = jsonDecode(response.body);
    // print(code);
  }

  Future<void> go(BuildContext context) async {
    await new Future.delayed(const Duration(seconds: 3));

    go1(context);
    setState(() {
      _isLoading = false;
      isSignUp = true;
      signedUp = true;
    });
  }

  Future<void> go1(BuildContext context) async {
    await new Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (Route<dynamic> route) => false);
    setState(() {
      isSignUp = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      key: _signupScaffold,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/plainbackground.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          child: _isLoading
              ? Center(
                  child: SpinKitCubeGrid(
                    color: Colors.black26,
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
                          child: Container(color: Colors.black.withOpacity(0)),
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
      floatingActionButton: isSignUp
          ? Container(
              child: signedUp
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
                  : Container(
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
                    ),
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
    go(context);

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
                      if (value == null) {
                        return 'Please select Title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _gender = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle, color: Colors.black),
                      hintText: "Title",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    items: _title.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _title = value;
                      });
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
                      flex: 2,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.grey[300],
                        ),
                        child: DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select an area';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _area = value;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              icon: Icon(Icons.map, color: Colors.black),
                              hintText: "Area Code",
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            items: _locations.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _area = value;
                              });
                            }),
                      )),
                  Expanded(
                    flex: 4,
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
                  }
                  return null;
                },
                onSaved: (String value) {
                  _email = value;
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
                          "${datePick.month}/${datePick.day}/${datePick.year}";
                    });
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
                    }),
              ),
              SizedBox(height: 30.0),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.grey[300],
                ),
                child: DropdownButtonFormField(
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
                      });
                    }),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 10),
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
                // Validate returns true if the form is valid, otherwise false.
                if (_signupFormKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  _signupFormKey.currentState.save();
                  print(_fName);
                  Map data = {
                    'title': _title,
                    'email': _email,
                    'firstName': _fName,
                    'lastName': _lName,
                    'phone': _phone,
                    'code': _area,
                    'nation': _nationality,
                    'gender': _gender,
                  };
                  print(data);
                  setState(() {
                    _isLoading = true;
                  });
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
            child: Text(
              "By signing up, I agree to the Terms of use and Privacy Policy of SAA Voyager.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
