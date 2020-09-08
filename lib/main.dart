import 'dart:ui';

import 'package:voyager/modules/home/pages/membership_card.dart';
import 'package:voyager/modules/home/widgets/barcodegenerator.dart';
import 'package:voyager/modules/hotdeals/pages/hotdeals.dart';
import 'package:voyager/modules/login/pages/login_screen.dart';
import 'package:voyager/modules/more_about_voyager/pages/about_voyager.dart';
import 'package:voyager/modules/my_account/pages/my_account.dart';
import 'package:voyager/modules/rewards_voucher/pages/reward_voucher_home.dart';
import 'package:voyager/screens/barcode_scan.dart';
import 'package:voyager/screens/forgot_pin.dart';
import 'package:voyager/screens/login_options.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/modules/home/pages/page_view_left.dart';
import 'package:voyager/screens/pin_login.dart';
import 'package:voyager/screens/set_pin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/modules/signup/pages/sign_up.dart';
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
        '/moreaboutvoyager': (BuildContext context) => MoreAboutVoyagerPage(),
      },
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;
  int selectedIndex = 0;
  String appbarTitle = "SAA Voyager";
  final widgetOptions = [
    PageViewSwipe(),
    RewardVoucherScreen(),
    Text('Miles'),
    HotDealsPage(),
    Text('Vouchers'),
    MyAccount(),
  ];
  List nav_button_color = [
    Colors.yellow,
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
              title: Text(appbarTitle, style: TextStyle(color: Colors.white)),
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
      switch (selectedIndex) {
        case 0:
          setState(() {
            appbarTitle = "SAA Voyager";
          });
          break;
        case 1:
          setState(() {
            appbarTitle = "Rewards and Vouchers";
          });
          break;
        case 2:
          setState(() {
            appbarTitle = "Miles";
          });
          break;
        case 3:
          setState(() {
            appbarTitle = "Hot Deals";
          });
          break;
        case 4:
          setState(() {
            appbarTitle = "Explore";
          });
          break;
        case 5:
          setState(() {
            appbarTitle = "Account";
          });
          break;
      }
    });
  }
}
