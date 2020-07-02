import 'package:chameleon/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chameleon/screens/sign_up.dart';
import 'package:chameleon/theme/theme.dart' as THEME;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(THEME.PRIMARY_COLOR),
      ),
      home: LoginPage(),
      routes: {
        '/signup': (BuildContext context) => SignUpPage(),
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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
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
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(THEME.BG_GRADIENT_COLOR_1),
                    Color(THEME.BG_GRADIENT_COLOR_2)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
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
              ),
            )
          ],
        ),
      ),
    );
  }

  removeSharedPreferenceKeys() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
