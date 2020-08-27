import 'dart:ui';

import 'package:voyager/modules/login/pages/login_screen.dart';
import 'package:voyager/screens/forgot_pin.dart';
import 'package:voyager/screens/login_options.dart';
import 'package:voyager/screens/login_page.dart';
import 'package:voyager/modules/home/pages/page_view_left.dart';
import 'package:voyager/screens/pin_login.dart';
import 'package:voyager/screens/set_pin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/screens/sign_up.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/services/getFingerprint.dart';
import 'package:voyager/theme/theme.dart' as THEME;

import 'modules/splash/pages/splash_screen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(THEME.PRIMARY_COLOR),
      ),
      home: SplashScreen(),
      routes: {
        '/signup': (BuildContext context) => SignUpPage(),
        '/forgotpin': (BuildContext context) => ForgotPin(),
        '/loginoptions': (BuildContext context) => LoginOptions(),
        '/getfingerprint': (BuildContext context) => AuthenticateFingerPrint(),
        '/setPin': (BuildContext context) => SetPin(),
        '/pinLogin': (BuildContext context) => PinLogin(),
      },
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;
  int selectedIndex = 0;
  final widgetOptions = [
    PageViewSwipe(),
    Text('Explore'),
    Text('Miles'),
    Text('Hot Deals'),
    Text('Vouchers'),
    Text('My acc'),
  ];
  List nav_button_color = [
    Color(0xffCB8A03),
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackgroundClass(),
        Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              backgroundColor: Color(THEME.PRIMARY_COLOR),
              title: Text("South African Airlines",
                  style: TextStyle(color: Colors.white)),
              centerTitle: true,
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    removeSharedPreferenceKeys();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()),
                        (Route<dynamic> route) => false);
                  },
                  child: Text("Log Out", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            body: Center(
              child: widgetOptions.elementAt(selectedIndex),
            ),
            bottomNavigationBar: new Theme(
              data: Theme.of(context).copyWith(
                  textTheme: Theme.of(context)
                      .textTheme
                      .copyWith(caption: new TextStyle(color: Colors.white))),
              child: new BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/home1.png",
                        width: 37.0,
                        color: nav_button_color[0],
                      ),
                      title: Text('Home')),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/redeem.png",
                        width: 40.0,
                        color: nav_button_color[1],
                      ),
                      title: Text(
                        'Rewards',
                        textAlign: TextAlign.start,
                      )),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/donate_points.png",
                        width: 40.0,
                        color: nav_button_color[2],
                      ),
                      title: Text('Miles')),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/hotdeals.png",
                        width: 40.0,
                        color: nav_button_color[3],
                      ),
                      title: Text('Hot Deals')),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.explore,
                        size: 40,
                      ),
                      title: Text('Explore')),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/account.png",
                        width: 40.0,
                        height: 40,
                        color: nav_button_color[5],
                      ),
                      title: Text('Account')),
                ],
                currentIndex: selectedIndex,
                backgroundColor: Color(THEME.PRIMARY_COLOR),
                fixedColor: Colors.yellow,
                onTap: onItemTapped,
              ),
            ))
      ],
    );
  }

  removeSharedPreferenceKeys() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  int i;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      nav_button_color[selectedIndex] = Colors.yellow;
      i = 0;
      while (i < 6) {
        if (i != selectedIndex) nav_button_color[i] = Colors.white;
        i++;
      }
    });
  }
}
