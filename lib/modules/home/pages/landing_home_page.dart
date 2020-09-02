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
  ProfileModel profileObject = LoginUser.profileModel;
  AccountModel accountModel = LoginUser.accountModel;

  @override
  Widget build(BuildContext context) {
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
                          AssetImage('assets/images/DefaultMaleProfile.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                child: Text(
              'Welcome ${profileObject.title} ${profileObject.givenName} ${profileObject.familyName}',
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
                      progressColor: Color(profileObject.tierColor)),
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "${profileObject.tierName}",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "get ${accountModel.getPointsToNextTier} more points",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          "${profileObject.nextTierName}",
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
                            "${profileObject.membershipId}",
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
                            "${accountModel.getPoints}",
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
                            "${profileObject.tierName}",
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
                            "${accountModel.getTierValidityDate}",
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
