import 'dart:core';
import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/screens/set_pin.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class ForgotPin extends StatefulWidget {
  ForgotPin({Key key}) : super(key: key);

  @override
  _ForgotPinState createState() => _ForgotPinState();
}

class _ForgotPinState extends State<ForgotPin> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  String memberShipNo;
  String email;

  final _forgotPinKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  final TextEditingController membershipController =
      new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final FocusNode _pinFocus = FocusNode();

  void initState() {
    super.initState();
    membershipController.addListener(() {
      final text = membershipController.text.toLowerCase();
      membershipController.value = membershipController.value.copyWith(
        text: text,
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
        ],
      ),
    );
  }

//Text Section with InkWell
  Container textSection() {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 40),
        child: Form(
          key: _forgotPinKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Container(
                child: Text(
                  "FORGOT PIN",
                  style: TextStyle(
                      fontSize: 18,
//                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                child: Text(
                  "Please enter your Membership No. & Email Address registered with us.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Membership No';
                  }
                  return null;
                },
                controller: membershipController,
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
                onFieldSubmitted: (term) {
                  _pinFocus.unfocus();
                },
                focusNode: _pinFocus,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Email Address';
                  }
                  return null;
                },
                controller: emailController,
                cursorColor: Colors.white,
                obscureText: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(Icons.email, color: Colors.black),
                  hintText: "Email Address",
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

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45.0,
      padding: EdgeInsets.only(left: 20, right: 15),
      child: RaisedButton(
        onPressed: () async {
          if (_forgotPinKey.currentState.validate()) {
            setState(() {
              _isLoading = true;
            });
            // signInWithEmail(
            //     membershipController.text.trim(), emailController.text.trim());
            await new Future.delayed(const Duration(seconds: 3));
            Navigator.push(
                context, new MaterialPageRoute(builder: (__) => LoginPage()));
          }
        },
        textColor: Colors.white,
        elevation: 0.0,
        color: Color(THEME.BUTTON_COLOR),
        child: Text("SUBMIT", style: TextStyle(color: Colors.black)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  setStoredVal(String memberShipId) async {
    await _storage.write(key: 'membershipId', value: memberShipId);
  }

  signInWithEmail(String membership, _email) {
    print("membership_no, email" + memberShipNo + " " + email);

    if ((membership == memberShipNo) && (_email == email)) {
      setStoredVal(membership);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => SetPin()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => ForgotPin()),
          (Route<dynamic> route) => false);
    }
  }
}
