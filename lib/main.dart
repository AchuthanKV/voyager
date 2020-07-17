import 'dart:ui';

import 'package:voyager/screens/login_options.dart';
import 'package:voyager/screens/login_page.dart';
import 'package:voyager/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/screens/sign_up.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/services/drawer.dart';
import 'package:voyager/services/getFingerprint.dart';
import 'package:voyager/theme/theme.dart' as THEME;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(THEME.PRIMARY_COLOR),
      ),
      home: WelcomePage(),
      routes: {
        '/signup': (BuildContext context) => SignUpPage(),
        '/loginoptions': (BuildContext context) => LoginOptions(),
        '/getfingerprint': (BuildContext context) => AuthenticateFingerPrint(),
      },
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackgroundClass(),
        Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text("SAA Voyager", style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  removeSharedPreferenceKeys();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
                child: Text("Log Out", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          drawer: Drawer(child: DrawerClass()),
          backgroundColor: Colors.transparent,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome to Dashboard",
                    style: TextStyle(
                        color: Color(THEME.PRIMARY_COLOR),
                        fontSize: 30,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  removeSharedPreferenceKeys() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
