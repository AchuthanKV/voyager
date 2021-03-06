// import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:swipedetector/swipedetector.dart';
import 'package:voyager/base/models/account_model.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/base/utils/sizeconfig.dart';
import 'package:voyager/modules/home/services/percentage_tier.dart';
import 'package:voyager/modules/login/services/accountsummary.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/modules/login/services/memberprofile.dart';
import 'package:voyager/modules/my-profile/pages/my_profile.dart';
import 'package:voyager/modules/transaction/pages/transaction_page.dart';
import 'package:voyager/modules/wishlist/pages/wishlist_home.dart';
import 'package:voyager/services/background.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
  static bool callApi = false;
  static String proPicUrl = "";
  static bool profilePic = false;
}

class _LandingPageState extends State<LandingPage> {
  ProfileModel profileObject = LoginUser.profileModel;
  AccountModel accountModel = LoginUser.accountModel;
  Tierpercentage tierpercentage = Tierpercentage();
  SizeConfig sizeConfig = SizeConfig();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  String picUrl = "male.png";
  double tierPercent = 0.0;

  profilepicUrl() async {
    sizeConfig.init(context);
    LandingPage.proPicUrl = await MyProfile().getPath();

    if (MyProfile.hasImage) {
      setState(() {
        LandingPage.profilePic = true;
      });
    } else {
      LandingPage.profilePic = false;
      String gender = profileObject.gender;
      gender = gender.toLowerCase();

      print(gender);
      if (gender != "m") {
        picUrl = "female.png";
      } else {
        picUrl = "male.png";
      }
    }
  }

  getTierPercent() {
    tierPercent = tierpercentage.go();
  }

  go() async {
    getTierPercent();
    if (LandingPage.callApi) {
      String membershipId = await _storage.read(key: 'membershipId');

      await MembershipProfile().getMembershipProfile(membershipId);

      await AccountSummary().getAccountSummary(membershipId);
      if (mounted) {
        setState(() {
          profileObject = LoginUser.profileModel;
          accountModel = LoginUser.accountModel;
          LandingPage.callApi = false;
        });
      } else {
        profileObject = LoginUser.profileModel;
        accountModel = LoginUser.accountModel;
        LandingPage.callApi = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    go();
    profilepicUrl();
    return Stack(
      children: [
        BackgroundClass(),
        Container(
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
                                    color: Colors.black),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Wishlist()));
                                }),
                            Text(
                              'Wishlist',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                            ),
                          ],
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                          onPressed: () async {
                            await Navigator.pushNamed(context, '/myprofile');
                            setState(() {});
                          },
                          child: MyProfile.hasImage
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.file(
                                    File(LandingPage.proPicUrl),
                                    height: SizeConfig.screenWidth / 2.5,
                                    width: SizeConfig.screenWidth / 2.5,
                                    fit: BoxFit.fitWidth,
                                  ))
                              : CircleAvatar(
                                  radius: SizeConfig.screenWidth / 5,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage('assets/images/${picUrl}'),
                                )),
                    )
                  ],
                ),
                Container(
                    child: Text(
                  'Welcome ${profileObject.title} ${profileObject.givenName} ${profileObject.familyName}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
                (profileObject.tierName.toLowerCase() != "lifetimeplatinum")
                    ? Container(
                        child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: LinearPercentIndicator(
                                lineHeight: 15.0,
                                percent: tierPercent,
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
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "You need ${accountModel.getPointsToNextTier} more miles",
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
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ]),
                        ],
                      ))
                    : SizedBox(
                        height: 0,
                      ),
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
        )
      ],
    );
  }
}
