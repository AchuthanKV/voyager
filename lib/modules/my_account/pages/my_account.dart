import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/base/utils/sizeconfig.dart';
import 'package:voyager/modules/logout/pages/logout.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class MyAccount extends StatefulWidget {
  MyAccount({Key key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  SizeConfig sizeConfig = SizeConfig();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List items = [
    "Personal Information",
    "Login Options",
    'Change Password',
    "Invite a Friend",
    "More About Voyager",
    "Log Out"
  ];
  List icons = [
    "assets/images/user_icon.png",
    "assets/images/biometric_icon.png",
    "assets/images/password_icon.png",
    "assets/images/invite_icon.png",
    "assets/images/moreabtvoy_icon.png",
    "assets/images/logout.png",
  ];

  List routingPath = [
    '/myprofile',
    "/loginoptions",
    '/changepin',
    "/invitefriend",
    "/moreaboutvoyager",
    "/logout"
  ];

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          BackgroundClass(),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 4 / 3,
              children: List.generate(items.length, (index) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: SizeConfig.screenWidth / 2 - 20,
                      // height: SizeConfig.screenHeight / 8,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          IconButton(
                            icon: Image.asset(icons[index],
                                color: Color(THEME.SAA_BLUE_COLOR), width: 50),
                            color: Colors.indigo[900],
                            iconSize: 50,
                            onPressed: () {
                              if (routingPath[index] == "/logout") {
                                Logout.showAlertDialog(
                                    _scaffoldKey.currentContext);
                              } else {
                                Navigator.pushNamed(
                                    context, routingPath[index]);
                              }
                            },
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              items[index],
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(THEME.SAA_BLUE_COLOR)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
