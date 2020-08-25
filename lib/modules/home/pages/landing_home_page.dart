import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/modules/transaction/pages/transaction_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  go() async {
    ProfileModel profileObject = LoginUser.obj;
    print(profileObject.emailAddress);
  }

  @override
  Widget build(BuildContext context) {
    go();
    return Container(
      child: SwipeDetector(
        child: Column(
          children: <Widget>[
            Container(
              child: SizedBox(height: 50),
            ),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                color: Colors.blueAccent,
                child: new Container(
                  // alignment: Alignment(0.2, 1),
                  height: 30.0,
                ),
              ),
            ),
            Container(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '  Blue',
                      style: TextStyle(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.start,
                    ))),
            Container(
              child: SizedBox(height: 30),
            ),
            Container(
                child: Text(
              'Welcome User',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            Container(
              child: SizedBox(height: 30),
            ),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                color: Colors.black,
                child: new Container(
                  padding: EdgeInsets.all(25.0),
                  margin: EdgeInsets.only(top: 10.0),
                  child: Table(
                    // border: TableBorder.all(width: 1),
                    columnWidths: {
                      0: FractionColumnWidth(.4),
                      1: FractionColumnWidth(.1),
                      2: FractionColumnWidth(.4)
                    },
                    children: [
                      TableRow(children: [
                        Column(children: [
                          Text(
                            'Membership ID:',
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                        Column(),
                        Column(children: [
                          Center(
                              child: Text(
                            '5001453267',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(
                          children: [
                            Text(
                              '',
                            ),
                          ],
                        ),
                        Column(),
                        Column(),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Text(
                            'Miles Balance:',
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                        Column(),
                        Column(children: [
                          Center(
                              child: Text(
                            '10000',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(
                          children: [
                            Text(
                              '',
                            ),
                          ],
                        ),
                        Column(),
                        Column(),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Text(
                            'Tier Status:',
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                        Column(),
                        Column(children: [
                          Center(
                              child: Text(
                            'Gold',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(
                          children: [
                            Text(
                              '',
                            ),
                          ],
                        ),
                        Column(),
                        Column(),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Text(
                            'Tier Expiry:',
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                        Column(),
                        Column(children: [
                          Center(
                              child: Text(
                            'NA',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ))
                        ]),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: SizedBox(height: 40),
            ),
            Expanded(
                child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.arrow_drop_up,
                        size: 18,
                      ),
                    ),
                    TextSpan(
                      text: "Swipe up for Transaction Details",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(height: 25)
          ],
        ),
        onSwipeUp: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => TransactionPage()));
        },
      ),
    );
  }
}
