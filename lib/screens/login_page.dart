import 'dart:async';
import 'dart:convert';
import 'dart:core';
//import 'dart:js';
import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:voyager/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/services/api.dart' as API;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:voyager/theme/theme.dart' as THEME;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  String errorMsg = '';
  String membership_no = '0000000000';
  String pin = '1234';
  String membership_no_new;

  final _loginFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  final TextEditingController membershipController =
      new TextEditingController();
  final TextEditingController pinController = new TextEditingController();
  final FocusNode _pinFocus = FocusNode();

  void initState() {
    super.initState();
    membershipController.addListener(() {
      final text = membershipController.text.toLowerCase();
      membershipController.value = membershipController.value.copyWith(
        text: text,
        // selection:
        //     TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //print('build execution...');
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: ClipRRect(
          // make sure we apply clip it properly
          child: _isLoading
              ? Center(
                  child: SpinKitHourGlass(
                    color: Colors.white,
                    size: 100.0,
                  ),
                )
              : ListView(
                  children: <Widget>[
                    logoSection(),
                    //pinLogin(),

                    SizedBox(
                      height: 50,
                    ),
                    normalSignIn(),
                  ],
                ),
        ),
      ),
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

  Container normalSignIn() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          textSection(),
          buttonSection(),
          forgotPasswordSection(),
        ],
      ),
    );
  }

//Text Section with InkWell
  Container textSection() {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 40),
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Membership No';
                  }
                  return null;
                },
                controller: membershipController,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_pinFocus);
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 30,
                  ),
                  hintText: "Membership No.",
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.number,
                onFieldSubmitted: (term) {
                  _pinFocus.unfocus();
                },
                focusNode: _pinFocus,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your PIN';
                  }
                  return null;
                },
                controller: pinController,
                cursorColor: Colors.white,
                obscureText: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(Icons.lock, color: Colors.black),
                  hintText: "PIN",
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ));
  }

  Container forgotPasswordSection() {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: EdgeInsets.only(left: 20, top: 10, right: 1),
      //alignment: Alignment(2.0, 10.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          inkWellSection("Forgot PIN?", '/forgotpin'),
          registerAccountSection()
        ],
      ),
    );
  }

  InkWell inkWellSection(String title, String path) {
    return InkWell(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 15,
            color: Color(THEME.PRIMARY_COLOR),
            decoration: TextDecoration.underline),
      ),
      onTap: () => Navigator.pushNamed(context, path),
    );
  }

  Container registerAccountSection() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("New User? ",
              style: TextStyle(color: Color(THEME.PRIMARY_COLOR))),
          InkWell(
            onTap: () => {
              Navigator.of(context).pushNamed('/signup'),
            },
            child: Text(
              'JOIN VOYAGER',
              style: TextStyle(
                color: Color(THEME.PRIMARY_COLOR),
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45.0,
      padding: EdgeInsets.only(left: 20, right: 15),
      child: RaisedButton(
        onPressed: () {
          if (_loginFormKey.currentState.validate()) {
            setState(() {
              _isLoading = true;
            });
            signIn(membershipController.text.trim(), pinController.text.trim());
            //signIn(emailController.text.trim(), passwordController.text.trim());
          }
        },
        textColor: Colors.white,
        elevation: 0.0,
        color: Color(THEME.BUTTON_COLOR),
        child: Text("SIGN IN", style: TextStyle(color: Colors.black)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  setStoredVal(String membershipid, String pin) async {
    await _storage.write(key: 'membershipId', value: membershipid);
    await _storage.write(key: 'pin', value: pin);
  }

  dummySignIn(String membership, _pin) {
    print("membership, _pin" + membership + " " + _pin);
    print("membership_no, pin" + membership_no + " " + pin);
    if (membership_no_new != null) {
      setState(() {
        membership_no = membership_no_new;
      });
    }
    if ((membership == membership_no) && (_pin == pin)) {
      setStoredVal(membership, _pin);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  signIn(String membershipId, pin) async {
    var response = await LoginUser().authenticateUser(membershipId, pin);
    if (response == 'true') {
      setStoredVal(membershipId, pin);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }
}
