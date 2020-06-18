import 'dart:convert';
import 'dart:core';
import 'package:chameleon/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chameleon/services/api.dart' as API;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:chameleon/theme/theme.dart' as THEME;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(THEME.BG_GRADIENT_COLOR_1),
            Color(THEME.BG_GRADIENT_COLOR_2)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(THEME.PRIMARY_COLOR)),
              ))
            : ListView(
                children: <Widget>[
                  logoSection(),
                  logoTitle(),
                  headerSection(),
                  textSection(),
                  forgotPasswordSection(),
                  buttonSection(),
                  registerAccountSection()
                ],
              ),
      ),
    );
  }

  Container logoSection() {
    return Container(
      alignment: Alignment(0.0, 0.0),
      height: 50.0,
      //width: 100.0,
      margin: EdgeInsets.only(top: 50.0),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/logo.png'),
        fit: BoxFit.fitHeight,
      )),
    );
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

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    var jsonResponse;
    var response = await http.post(API.LOGIN_API,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
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
      //print(response.body);
    }
  }

//Header Section
  Container headerSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text(
        "Sign In",
        style: GoogleFonts.raleway(
          textStyle: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
      ),
    );
  }

//Text Section with InkWell
  Container textSection() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Email ID';
                  }
                  return null;
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
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                controller: passwordController,
                cursorColor: Colors.white,
                obscureText: true,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.lock, color: Colors.white70),
                  hintText: "Password",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ));
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
      margin: EdgeInsets.only(top: 55.0),
      child: RaisedButton(
        onPressed: () {
          if (_loginFormKey.currentState.validate()) {
            setState(() {
              _isLoading = true;
            });
            signIn(emailController.text.trim(), passwordController.text.trim());
          }
        },
        textColor: Colors.white,
        elevation: 0.0,
        color: Color(THEME.PRIMARY_COLOR),
        child: Text("Sign In", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Container registerAccountSection() {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Don't have an account?", style: TextStyle(color: Colors.white)),
          InkWell(
            onTap: () => {
              Navigator.of(context).pushNamed('/signup'),
            },
            child: Text(
              'Sign up',
              style: TextStyle(
                  color: Color(THEME.PRIMARY_COLOR),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
        //teinkWellSection("Don't have an account? Sign up"
      ),
    );
  }

  _displaySnackBar(BuildContext context, var response) {
    print(response);
    var msg = response['errors'][0]['msg'];
    // print(jsonObj);
    // var msg;
    // if (jsonObj.isEmpty()) {
    //   msg = jsonObj;
    // } else {
    //   msg = 'Something went wrong!';
    // }
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
