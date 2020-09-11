import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/modules/miles/pages/miles_infopage.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class ClaimMilesPage extends StatefulWidget {
  @override
  _ClaimMilesPageState createState() => _ClaimMilesPageState();
}

class _ClaimMilesPageState extends State<ClaimMilesPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[600],
                offset: Offset(0.0, 1.0),
                blurRadius: 6.0,
              ),
            ],
            image: DecorationImage(
              image: new AssetImage("assets/images/plainbackground.png"),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  onPressed: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.flight,
                            size: 30,
                            color: Color(THEME.PRIMARY_COLOR),
                          ),
                        ),
                        Text(
                          "Flight",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(THEME.PRIMARY_COLOR),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MilesInfoPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.location_city,
                            size: 30,
                            color: Color(THEME.PRIMARY_COLOR),
                          ),
                        ),
                        Text(
                          "Hotel",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(THEME.PRIMARY_COLOR),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MilesInfoPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.directions_car,
                            size: 30,
                            color: Color(THEME.PRIMARY_COLOR),
                          ),
                        ),
                        Text(
                          "Car",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(THEME.PRIMARY_COLOR),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MilesInfoPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.local_bar,
                            size: 30,
                            color: Color(THEME.PRIMARY_COLOR),
                          ),
                        ),
                        Text(
                          "Dine",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(THEME.PRIMARY_COLOR),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MilesInfoPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.directions_boat,
                            size: 30,
                            color: Color(THEME.PRIMARY_COLOR),
                          ),
                        ),
                        Text(
                          "Cruise",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(THEME.PRIMARY_COLOR),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MilesInfoPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ImageIcon(
                            AssetImage("assets/images/claimmiles.png"),
                            size: 25,
                            color: Color(THEME.PRIMARY_COLOR),
                          ),
                        ),
                        Text(
                          "Claim",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(THEME.PRIMARY_COLOR),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
