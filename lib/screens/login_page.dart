import 'dart:async';
import 'dart:convert';
import 'dart:core';
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
import 'package:voyager/services/api.dart' as API;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:voyager/theme/theme.dart' as THEME;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  String errorMsg = '';
  final username = 'admin';
  String mail = 'admin@gmail.com';
  final password = 'admin';
  String mailNew;

  bool _isNormalSignIn = true;
  String _nextSignInText = "SignIn With FingerPrint";
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  final LocalAuthentication _autherization = LocalAuthentication();
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  bool isAuthenticated = false;
  bool _canChkBiomeric = false;
  String _authOrNot = "Not Authorized";
  List<BiometricType> _availBiometrics = List<BiometricType>();

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _autherization.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canChkBiomeric = canCheckBiometric;
    });
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _autherization.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availBiometrics = listOfBiometrics;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      print('Is finger print available : ' + _canChkBiomeric.toString());
      if (_canChkBiomeric) {
        isAuthorized = await _autherization.authenticateWithBiometrics(
          localizedReason: "Please authenticate to complete your transaction",
          useErrorDialogs: false,
          stickyAuth: true,
        );
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == auth_error.passcodeNotSet) {
        // Handle this exception here.
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Authentication Alert !"),
                content: Text("Fingerprint not recorded or not provided."),
              );
            });
      }
      _autherization.stopAuthentication();
    } on Exception catch (e) {
      print(e);
    }

    print('----- Autherised ? ' + isAuthorized.toString());
    print('-----    mounted ? ' + mounted.toString());

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authOrNot = "Authorized";
        dummySignIn('admin', true);
        _isLoading = true;
      } else {
        setState(() {
          _authOrNot = "Not Authorized";
        });
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text("Authentication Alert !"),
        //         content: Text("Fingerprint not recorded or not porvided."),
        //       );
        //     });
      }
    });

    // call dummySignIn
    //if (_loginFormKey.currentState.validate()) {
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  final _loginFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final FocusNode _pinFocus = FocusNode();

  bool isBiometric = false;

  setStoredVal(val) async {
    await _storage.write(key: 'biometric', value: val);
    setState(() {
      if (val == 'false')
        isBiometric = false;
      else
        isBiometric = true;
    });
  }

  getStoredVal() async {
    var isBio = await (_storage.read(key: 'biometric'));
    print('bio...:');
    print(isBio);
    if (isBio != null && isBio != 'undefined') {
      setState(() {
        if (isBio == 'false')
          isBiometric = false;
        else
          isBiometric = true;
      });
    }
  }

  void initState() {
    super.initState();
    getStoredVal();
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

  Future newUserAdd() async {
    mailNew = await (_storage.read(key: 'mail_id'));
    if (mailNew != null)
      print(mailNew);
    else
      print("Null");
  }

  @override
  Widget build(BuildContext context) {
    newUserAdd();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          //gradient: LinearGradient(colors: [
          //  Color(THEME.BG_GRADIENT_COLOR_1),
          //  Color(THEME.BG_GRADIENT_COLOR_2)
          //], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          image: DecorationImage(
            image: ExactAssetImage("assets/images/saa2.jpg"),
            fit: BoxFit.fill,
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
                      child: SpinKitHourGlass(
                        color: Colors.white,
                        size: 100.0,
                      ),
                    )
                  : ListView(
                      children: <Widget>[
                        // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        //chkBiometric(_canChkBiomeric),
                        //listBiometrics(_availBiometrics),
                        // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        logoSection(),
                        pinLogin(),
                        //logoTitle(),
                        // headerSection(),
                        SizedBox(
                          height: 50,
                        ),
                        normalOrBio(),
                        (_isNormalSignIn) ? normalSignIn() : biometricAuth(),
                        registerAccountSection()
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Container pinLogin() {
    return Container(
        alignment: Alignment(1, 0.0),
        child: inkWellSection('Sign in with pin', '/pinLogin'));
  }

  Container normalOrBio() {
    if (isBiometric) {
      _checkBiometric();
      if (_canChkBiomeric) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
          alignment: Alignment(1.0, 0.0),
          child: normalSignInLnk(),
        );
      } else {
        return plainContainer();
      }
    } else {
      return plainContainer();
    }
  }

  Container plainContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
      alignment: Alignment(1.0, 0.0),
    );
  }

  InkWell normalSignInLnk() {
    return InkWell(
      child: Text(
        _nextSignInText,
        style: TextStyle(
            color: Color(THEME.PRIMARY_COLOR),
            decoration: TextDecoration.underline),
      ),
      onTap: () => {
        setState(() {
          if (_isNormalSignIn) {
            _isNormalSignIn = false;
            _nextSignInText = "SignIn With Pin";
            _authorizeNow();
          } else {
            try {
              //bool isAuthorized = false;
              _autherization.stopAuthentication();
              //print('Authorize: ' + isAuthorized);
            } on PlatformException catch (e) {
              print(e);
            }
            _isNormalSignIn = true;
            _nextSignInText = "SignIn With FingerPrint";
          }
        })
      },
    );
  }

  Container normalSignIn() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          textSection(),
          forgotPasswordSection(),
          buttonSection()
        ],
      ),
    );
  }

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  Container chkBiometric(_canChkBiomeric) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Can we check Biometric : $_canChkBiomeric"),
          RaisedButton(
            onPressed: _checkBiometric,
            child: Text("Check Biometric"),
            color: Colors.green,
            colorBrightness: Brightness.light,
          )
        ],
      ),
    );
  }

  Container listBiometrics(_availBiometrics) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("List Of Biometric : ${_availBiometrics.toString()}"),
          RaisedButton(
            onPressed: _getListOfBiometricTypes,
            child: Text("List of Biometric Types"),
            color: Colors.green,
            colorBrightness: Brightness.light,
          )
        ],
      ),
    );
  }

  Container biometricAuth() {
    return Container(
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     //Text("Authorized : $_authOrNot"),
        //     RaisedButton(
        //       onPressed: _authorizeNow,
        //       //child: Text("Sign In With FingerPrint",
        //       //    style: TextStyle(color: Colors.white)),
        //       //color: Color(THEME.PRIMARY_COLOR),
        //       //shape: RoundedRectangleBorder(
        //       //    borderRadius: BorderRadius.circular(5.0)),
        //       //colorBrightness: Brightness.light,
        //     ),
        //   ],
        // ),
        );
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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

  signIn(String email, pass) async {
    /* SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
    } */
  }

//Header Section
  Container headerSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text(
        "Sign In",
        style: GoogleFonts.raleway(
          textStyle:
              TextStyle(color: Color(THEME.PRIMARY_COLOR), fontSize: 25.0),
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
                    return 'Please enter your Email ID/ Membership Id';
                  }
                  return null;
                },
                controller: emailController,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_pinFocus);
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Color(THEME.PRIMARY_COLOR)),
                decoration: InputDecoration(
                  icon: Icon(Icons.email, color: Color(THEME.PRIMARY_COLOR)),
                  hintText: "Membership No. / Email ID",
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
                onFieldSubmitted: (term) {
                  _pinFocus.unfocus();
                },
                focusNode: _pinFocus,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                controller: passwordController,
                cursorColor: Colors.white,
                obscureText: true,
                style: TextStyle(color: Color(THEME.PRIMARY_COLOR)),
                decoration: InputDecoration(
                  icon: Icon(Icons.lock, color: Color(THEME.PRIMARY_COLOR)),
                  hintText: "Pin",
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
            ],
          ),
        ));
  }

  Container forgotPasswordSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
      alignment: Alignment(1.0, 0.0),
      child: inkWellSection("Forgot Password?", '/forgotPass'),
    );
  }

  InkWell inkWellSection(String title, String path) {
    return InkWell(
      child: Text(
        title,
        style: TextStyle(
            color: Color(THEME.PRIMARY_COLOR),
            decoration: TextDecoration.underline),
      ),
      onTap: () => Navigator.pushNamed(context, path),
    );
  }

  dummySignIn(String email, pass) {
    if (mailNew != null) {
      setState(() {
        mail = mailNew;
      });
    }
    if ((email == username || email == mail) && (pass == password || pass)) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
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
            dummySignIn(
                emailController.text.trim(), passwordController.text.trim());
            //signIn(emailController.text.trim(), passwordController.text.trim());
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
          Text("New User? ",
              style: TextStyle(color: Color(THEME.PRIMARY_COLOR))),
          InkWell(
            onTap: () => {
              Navigator.of(context).pushNamed('/signup'),
            },
            child: Text(
              'Join Voyager',
              style: TextStyle(
                  color: Color(THEME.SECONDARY_COLOR),
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
