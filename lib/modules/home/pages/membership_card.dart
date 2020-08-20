import 'package:flutter/material.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class MembershipCardPage extends StatefulWidget {
  MembershipCardPage({Key key}) : super(key: key);

  @override
  _MembershipCardPageState createState() => _MembershipCardPageState();
}

Container logoSection() {
  return Container(
    alignment: Alignment(0.0, 0.0),
    height: 120.0,
    //width: 100.0,
    margin: EdgeInsets.only(top: 40.0, bottom: 50),
    decoration: BoxDecoration(
        image: DecorationImage(
      image: AssetImage('assets/images/Logo_SAAVBlue.png'),
      fit: BoxFit.fitHeight,
    )),
  );
}

Container userData() {
  return Container(
      alignment: Alignment(0.0, 0.0),
      height: 120.0,
      child: Container(
        color: Color(0xff104174).withOpacity(0.8),
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
                  "MR JOHN DOE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                Text(
                  "MEMBER NO: 0000000000",
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
                "Exp: NA",
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

class _MembershipCardPageState extends State<MembershipCardPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/images/membershipcard.png"),
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
          children: <Widget>[
            logoSection(),
            userData(),
          ],
        )
      ],
    );
  }
}
