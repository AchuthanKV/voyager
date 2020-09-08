import 'package:flutter/material.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/modules/vouchers/pages/car_voucher.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class CarRewardCataloguePage extends StatefulWidget {
  CarRewardCataloguePage({Key key}) : super(key: key);

  @override
  _CarRewardCataloguePageState createState() => _CarRewardCataloguePageState();
}

class _CarRewardCataloguePageState extends State<CarRewardCataloguePage> {
  @override
  Widget build(BuildContext context) {
    List carPictures = [
      "assets/images/non_air_avis.png",
      /*
            R.drawable.non_air_bidvest,*/
      "assets/images/non_air_europcar.png"
    ];

    List carName = [
      "Avis Car\nRental (Pty) Limited",
      /*
            "Bidvest Car Rental",*/
      "Europcar\nInternational"
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Rewards Catalogue'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
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
                    "Car Reward",
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
                          child: Image.asset(carPictures[0]),
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  carName[0],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(THEME.PRIMARY_COLOR),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
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
                                                builder: (__) => CarVoucher()));
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
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        child: Image.asset(carPictures[1]),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Text(
                                  carName[1],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(THEME.PRIMARY_COLOR),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 0, bottom: 20),
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
                                                builder: (__) => CarVoucher()));
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
