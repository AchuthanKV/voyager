import 'dart:convert';
import 'dart:core';
import 'dart:ui';
import 'package:chameleon/main.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chameleon/services/api.dart' as API;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:chameleon/theme/theme.dart' as THEME;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signupFormKey = GlobalKey<FormState>();
  final _signupScaffold = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  final TextEditingController initialController = new TextEditingController();
  final TextEditingController areaController = new TextEditingController();
  final TextEditingController dob = new TextEditingController();
  final TextEditingController nationalityController =
      new TextEditingController();
  final TextEditingController genderController = new TextEditingController();

  final TextEditingController emailController = new TextEditingController();
  //final TextEditingController passController = new TextEditingController();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  //final TextEditingController confirmPassController =
  //    new TextEditingController();
  String _fName;
  String _lName;
  String _email;
  String _phone;
  //String _confPassword;
  String _selectedLocation;
  List<String> _locations = ['A', 'B', 'C', 'D'];

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
                      child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Color(THEME.PRIMARY_COLOR)),
                    ))
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
    }
  }

  Container logoTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(
        "Chameleon",
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
                cursorColor: Color(THEME.PRIMARY_COLOR),
                style: TextStyle(color: Color(THEME.PRIMARY_COLOR)),
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle,
                      color: Color(THEME.PRIMARY_COLOR)),
                  hintText: "First Name",
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  hintStyle: TextStyle(color: Color(THEME.PRIMARY_COLOR)),
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
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
                cursorColor: Color(THEME.PRIMARY_COLOR),
                style: TextStyle(color: Color(THEME.PRIMARY_COLOR)),
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle,
                      color: Color(THEME.PRIMARY_COLOR)),
                  hintText: "Last Name",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  hintStyle: TextStyle(color: Color(THEME.PRIMARY_COLOR)),
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
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
                cursorColor: Color(THEME.PRIMARY_COLOR),
                style: TextStyle(color: Color(THEME.PRIMARY_COLOR)),
                decoration: InputDecoration(
                  icon: Icon(Icons.email, color: Color(THEME.PRIMARY_COLOR)),
                  hintText: "Email",
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  hintStyle: TextStyle(color: Color(THEME.PRIMARY_COLOR)),
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: DropDownFormField(
                      titleText: 'Area Code',
                      hintText: ' ',
                      value: _selectedLocation,
                      onChanged: (value) {
                        setState(() {
                          _selectedLocation = value;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          _selectedLocation = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "India +91",
                          "value": "+91",
                        },
                        {
                          "display": "Indonesia 72",
                          "value": "72",
                        },
                      ],
                      textField: 'value',
                      valueField: 'display',
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
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
                      cursorColor: Color(THEME.PRIMARY_COLOR),
                      style: TextStyle(color: Color(THEME.PRIMARY_COLOR)),
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone,
                            color: Color(THEME.PRIMARY_COLOR)),
                        hintText: "Phone",
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                        hintStyle: TextStyle(color: Color(THEME.PRIMARY_COLOR)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
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
              //'password': _confPassword
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
        child: Text("Sign Up", style: TextStyle(color: Colors.white)),
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
