import 'dart:ui';

import 'package:voyager/screens/login_options.dart';
import 'package:voyager/screens/login_page.dart';
import 'package:voyager/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/screens/sign_up.dart';
import 'package:voyager/theme/theme.dart' as THEME;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(THEME.PRIMARY_COLOR),
      ),
      home: WelcomePage(),
      routes: {
        '/signup': (BuildContext context) => SignUpPage(),
        '/loginoptions': (BuildContext context) => AuthenticateFingerprint(),
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
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
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
                  ))),
        ),
        Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text("South African Airlines",
                style: TextStyle(color: Colors.white)),
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
          drawer: Drawer(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage("assets/images/saa1.jpg"),
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
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'User',
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                            width: 280,
                            height: 40,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10, color: Colors.transparent)
                                ],
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                            child: RaisedButton(
                              color: Colors.transparent,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/loginoptions');
                              },
                              child: Text(
                                'Login Options',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Positioned(
                  child: Stack(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Welcome to Dashboard",
                          style: TextStyle(
                              color: Color(THEME.PRIMARY_COLOR),
                              fontSize: 30,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                    ],
                  ),
                )
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
