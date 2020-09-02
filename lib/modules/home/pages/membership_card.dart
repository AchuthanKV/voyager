import 'package:flutter/material.dart';
import 'package:voyager/base/models/account_model.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/modules/home/widgets/barcodegenerator.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class MembershipCardPage extends StatefulWidget {
  MembershipCardPage({Key key}) : super(key: key);

  @override
  _MembershipCardPageState createState() => _MembershipCardPageState();
}

class _MembershipCardPageState extends State<MembershipCardPage> {
  ProfileModel profileObject = LoginUser.profileModel;
  AccountModel accountModel = LoginUser.accountModel;
  String url;
  int tierColor;

  Container logoSection() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment(0.0, 0.0),
            height: 120.0,
            //width: 100.0,

            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/card_logo.png'),
              fit: BoxFit.fitHeight,
            )),
          ),
          Container(
            child: Text("${profileObject.tierName}",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }

  Container userData() {
    return Container(
        alignment: Alignment(0.0, 0.0),
        width: MediaQuery.of(context).size.width - 10,
        height: 120.0,
        child: Container(
          color: Color(tierColor).withOpacity(0.8),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${profileObject.title} ${profileObject.givenName} ${profileObject.familyName}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                  Text(
                    "MEMBER NO:  ${profileObject.membershipId}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Exp: ${accountModel.getTierValidityDate}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }

  getCardDetails() {
    String tierName = profileObject.tierName;

    switch (tierName) {
      case "Blue":
        url = "blue_card";
        tierColor = THEME.TIER_BLUE;
        break;
      case "Silver":
        url = "silver_card";
        tierColor = THEME.TIER_SILVER;
        break;
      case "Gold":
        url = "gold_card";
        tierColor = THEME.TIER_GOLD;
        break;
      case "Platinum":
        url = "plat_card";
        tierColor = THEME.TIER_PLATINUM;
        break;
      case "LifetimePlatinum":
        tierColor = THEME.TIER_LIFETIMEPLATINUM;
        url = "plat_card";
        break;
      default:
        url = "blue_card";
        tierColor = THEME.TIER_BLUE;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    getCardDetails();
    return Stack(
      children: <Widget>[
        Container(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/images/${url}.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: ClipRRect(
                // make sure we apply clip it properly
                child: Container(
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.1),
            )),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            logoSection(),
            userData(),
            BarcodeGen(),
          ],
        )
      ],
    );
  }
}
