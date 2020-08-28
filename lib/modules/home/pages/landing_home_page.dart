import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:voyager/base/models/account_model.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/modules/transaction/pages/transaction_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  ProfileModel profileObject;
  go() async {
    ProfileModel profileObject = LoginUser.profileModel;
    print(profileObject.tierName);
    print(profileObject.tierColor);
    AccountModel accountModel = LoginUser.accountModel;
    print(accountModel.getMembershipNumber);
    print(accountModel.getTierCode);
    print(accountModel.getTierPoints);
    print(accountModel.getTierName);
  }

  @override
  Widget build(BuildContext context) {
    go();
    return Container(
      child: SwipeDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                            icon: Image.asset("assets/images/wishlist.png",
                                color: Colors.indigo[900]),
                            onPressed: () {
                              //Wishlist method has to be called here
                              //Navigator
                            }),
                        Text(
                          'Wishlist',
                          style: TextStyle(
                              color: Colors.indigo[900], fontSize: 11),
                        ),
                      ],
                    )),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.yellow[700],
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/images/DefaultProfilePic.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                child: Text(
              'Welcome John',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            Container(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: LinearPercentIndicator(
                    lineHeight: 15.0,
                    percent: 0.74,
                    backgroundColor: Colors.grey[400],
                    progressColor: Colors.indigo[900],
                  ),
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "   Blue",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "10000 miles to go",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          "Silver   ",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ]),
              ],
            )),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                color: Colors.transparent,
                child: new Container(
                  child: Table(
                    columnWidths: {
                      0: FractionColumnWidth(.4),
                      1: FractionColumnWidth(.1),
                      2: FractionColumnWidth(.4)
                    },
                    children: [
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
                            'Membership ID:',
                            style: TextStyle(color: Colors.black),
                          )
                        ]),
                        Column(),
                        Column(children: [
                          Center(
                              child: Text(
                            '5001453267',
                            style: TextStyle(color: Colors.black),
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
                            style: TextStyle(color: Colors.black),
                          )
                        ]),
                        Column(),
                        Column(children: [
                          Center(
                              child: Text(
                            '10000',
                            style: TextStyle(color: Colors.black),
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
                            style: TextStyle(color: Colors.black),
                          )
                        ]),
                        Column(),
                        Column(children: [
                          Center(
                              child: Text(
                            'Blue',
                            style: TextStyle(color: Colors.black),
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
                            style: TextStyle(color: Colors.black),
                          )
                        ]),
                        Column(),
                        Column(children: [
                          Center(
                              child: Text(
                            'NA',
                            style: TextStyle(color: Colors.black),
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
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
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
              ),
            ),
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
