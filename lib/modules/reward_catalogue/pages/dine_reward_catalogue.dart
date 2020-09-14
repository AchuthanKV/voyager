import 'package:flutter/material.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/modules/vouchers/pages/dine_voucher.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class DineRewardCataloguePage extends StatefulWidget {
  DineRewardCataloguePage({Key key}) : super(key: key);

  @override
  _DineRewardCataloguePageState createState() =>
      _DineRewardCataloguePageState();
}

class _DineRewardCataloguePageState extends State<DineRewardCataloguePage> {
  @override
  Widget build(BuildContext context) {
    List dinePictures = [
      "assets/images/non_air_healthspa.png",
      /*
           "assets/images/uberlogo.png"*/
    ];

    List dineName = [
      "Health Spas Guide" /*, "Uber" */
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Rewards Catalogue'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text("Log Out",
                            style:
                                TextStyle(color: Color(THEME.PRIMARY_COLOR))),
                        content: Text("Do you want to log out ?",
                            style:
                                TextStyle(color: Color(THEME.TERTIARY_COLOUR))),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text("Yes",
                                style: TextStyle(
                                    color: Color(THEME.PRIMARY_COLOR))),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()));
                            },
                          ),
                          new FlatButton(
                            child: new Text("No",
                                style: TextStyle(
                                    color: Color(THEME.PRIMARY_COLOR))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Image.asset(
                "assets/images/logout.png",
                color: Colors.white,
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
        body: Stack(children: [
          BackgroundClass(),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  child: Text(
                    "Lifestyle Reward",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(THEME.PRIMARY_COLOR)),
                  ),
                )),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          child: Image.asset(dinePictures[0]),
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 20, right: 20),
                                child: Text(
                                  dineName[0],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(THEME.PRIMARY_COLOR),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 30, right: 20),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Image.asset(
                                        "assets/images/wishlist_round_1.png",
                                        color: Colors.indigo[900],
                                      ),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Image.asset(
                                          "assets/images/voucher_round.png",
                                          color: Colors.indigo[900]),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (__) =>
                                                    DineVoucher()));
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
