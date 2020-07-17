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

  final TextEditingController initialController = new TextEditingController();
  final TextEditingController areaController = new TextEditingController();
  final TextEditingController dobController = new TextEditingController();
  final TextEditingController nationalityController =
      new TextEditingController();
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
    http.Response response = await http.get('http://country.io/phone.json');
    Map code = jsonDecode(response.body);
    print(code);
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
            image: ExactAssetImage("assets/images/saa2.jpg"),
            fit: BoxFit.fill,
            //gradient: LinearGradient(colors: [
            //  Color(THEME.BG_GRADIENT_COLOR_1),
            //  Color(THEME.BG_GRADIENT_COLOR_2)
            //], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        child: ClipRRect(
          // make sure we apply clip it properly
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.1),
              child: _isLoading
                  ? Center(
                      child: SpinKitCubeGrid(
                        color: Colors.white,
                        size: 100.0,
                      ),
                    )
                  : ListView(
                      children: <Widget>[
                        logoSection(),
                        //logoTitle(),
                        // headerSection(),
                        textSection(),
                        buttonSection(),
                        //goBackSection()
                      ],
                    ),
            ),
          ),
        ),
      ),
      floatingActionButton: isSignUp
          ? Container(
              alignment: Alignment(0, 0),
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lightGreen[300],
              ),
              child: signedUp
                  ? Text("New User is Enrolled!!",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
                  : Text(
                      "Enrolling New user....",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
            )
          : null,
    );
  }

  Container logoSection() {
    return Container(
      alignment: Alignment(0.0, 0.0),
      height: 130.0,
      //width: 100.0,
      margin: EdgeInsets.only(top: 50.0),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/logo.png'),
        fit: BoxFit.fitHeight,
      )),
    );
  }

  signUpPage(Map data) async {
    isSignUp = true;
    _storage.write(key: "mail_id", value: emailController.text);
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
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Form(
          key: _signupFormKey,
          child: Column(
            children: <Widget>[
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
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle, color: Colors.white70),
                  hintText: "First Name",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  hintStyle: TextStyle(color: Colors.white70),
                  //Color(THEME.PRIMARY_COLOR)
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
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle, color: Colors.white70),
                  //Color(THEME.PRIMARY_COLOR)
                  hintText: "Last Name",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  hintStyle: TextStyle(color: Colors.white70),
                ),
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
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.email, color: Colors.white70),
                  hintText: "Email",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  hintStyle: TextStyle(color: Colors.white70),
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
                    _dobString = "Select date of birth";
                  });
                },
                onSaved: (String value) {},
                controller: dobController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today, color: Colors.white70),
                  hintText: _dobString,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(height: 30.0),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.blueGrey,
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
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white70),
                      hintText: "Select Gender",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                      hintStyle: TextStyle(color: Colors.white70),
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
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.blueGrey,
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
                            style: TextStyle(color: Colors.white70),
                            decoration: InputDecoration(
                              icon: Icon(Icons.map, color: Colors.white70),
                              hintText: "Area Code",
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(THEME.PRIMARY_COLOR))),
                              hintStyle: TextStyle(color: Colors.white70),
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
                      style: TextStyle(color: Colors.white70),
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone, color: Colors.white70),
                        hintText: "Phone",
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                        hintStyle: TextStyle(color: Colors.white70),
                        //Color(THEME.PRIMARY_COLOR)
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.blueGrey,
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
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                      icon: Icon(Icons.language, color: Colors.white70),
                      hintText: "Select Nationality",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                      hintStyle: TextStyle(color: Colors.white70),
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
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: RaisedButton(
        onPressed: () {
          // Validate returns true if the form is valid, otherwise false.
          if (_signupFormKey.currentState.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            _signupFormKey.currentState.save();
            print(_fName);
            Map data = {
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
        color: Color(THEME.PRIMARY_COLOR),
        child: Text("Sign Up", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  // Container goBackSection() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 40.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         InkWell(
  //           onTap: () => {
  //             Navigator.of(context).pop(context),
  //           },
  //           child: Text(
  //             'Go back',
  //             style: TextStyle(
  //                 color: Color(THEME.PRIMARY_COLOR),
  //                 decoration: TextDecoration.underline,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //         )
  //       ],
  //       //teinkWellSection("Don't have an account? Sign up"
  //     ),
  //   );
  // }

  _displaySnackBar(BuildContext context, var response) {
    print(response);
    var jsonObj = response['errors']['msg'];
    var msg;
    if (jsonObj.isEmpty) {
      msg = jsonObj;
    } else {
      msg = 'Something went wrong!';
    }
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    );
    _signupScaffold.currentState.showSnackBar(snackBar);
  }
}
