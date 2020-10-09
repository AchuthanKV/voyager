import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/base/models/wishlist_item_model.dart';
import 'package:voyager/base/utils/sizeconfig.dart';
import 'package:voyager/modules/reward_catalogue/pages/car_reward_catalogue.dart';
import 'package:voyager/modules/reward_catalogue/pages/cruise_reward_catalogue.dart';
import 'package:voyager/modules/reward_catalogue/pages/dine_reward_catalogue.dart';
import 'package:voyager/modules/reward_catalogue/pages/flight_reward_catalogue.dart';
import 'package:voyager/modules/wishlist/pages/flight_wishlist.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class Wishlist extends StatefulWidget {
  Wishlist({Key key}) : super(key: key);
  static List<Map> wishList = [];
  static List<WishlistItemModel> flightList = [];

  go() {
    createState().go();
  }

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List<Map> wishList = [];
  List<WishlistItemModel> flightList = [];
  List<WishlistItemModel> carList = [];
  List<WishlistItemModel> dineList = [];
  List<WishlistItemModel> cruiseList = [];
  go() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // wishList.clear();
    // flightList.clear();

    if (wishList.length == 0) {
      if (sharedPreferences.containsKey("wishlist")) {
        List list = await json.decode(sharedPreferences.getString("wishlist"));

        list.forEach((element) {
          wishList.add({
            "category": element['category'],
            "airAwardType": element['airAwardType'],
            "airSearchType": element['airSearchType'],
            "awardName": element['awardName'],
            "awardPicture": element['awardPicture'],
          });
          if (element['category'] == "flight") {
            flightList.add(new WishlistItemModel(
              "flight",
              element['awardName'],
              element['awardPicture'],
              element['airSearchType'],
              element['airAwardType'],
            ));
          } else if (element['category'] == "car") {
            carList.add(new WishlistItemModel(
              "flight",
              element['awardName'],
              element['awardPicture'],
              element['airSearchType'],
              element['airAwardType'],
            ));
          } else if (element['category'] == "dine") {
            dineList.add(new WishlistItemModel(
              "flight",
              element['awardName'],
              element['awardPicture'],
              element['airSearchType'],
              element['airAwardType'],
            ));
          } else if (element['category'] == "cruise") {
            cruiseList.add(new WishlistItemModel(
              "flight",
              element['awardName'],
              element['awardPicture'],
              element['airSearchType'],
              element['airAwardType'],
            ));
          }
        });
      }
    }
    Wishlist.flightList = flightList;
    Wishlist.wishList = wishList;
  }

  SizeConfig sizeConfig = SizeConfig();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    go();

    sizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
      ),
      body: Stack(
        children: [
          BackgroundClass(),
          Container(
              height: double.infinity,
              //margin: EdgeInsets.all(10),
              //padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       right: 200, bottom: 30, top: 20),
                        //   child: Text(
                        //     "WishlisT",
                        //     textAlign: TextAlign.left,
                        //     style: TextStyle(
                        //         fontSize: 17,
                        //         fontWeight: FontWeight.bold,
                        //         color: Color(THEME.SAA_BLUE_COLOR)),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[600],
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 6.0,
                                  ),
                                ],
                                image: DecorationImage(
                                  image: new AssetImage(
                                      "assets/images/plainbackground.png"),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            margin: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        FlightWishlist()));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset:
                                                    Offset(0.0, 1.0), //(x,y)
                                                blurRadius: 6.0,
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.flight,
                                                size: 30,
                                                color:
                                                    Color(THEME.SAA_BLUE_COLOR),
                                              ),
                                            ),
                                            Text(
                                              "Flight",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color:
                                                    Color(THEME.SAA_BLUE_COLOR),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    CarRewardCataloguePage()));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset:
                                                    Offset(0.0, 1.0), //(x,y)
                                                blurRadius: 6.0,
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.directions_car,
                                                size: 30,
                                                color:
                                                    Color(THEME.SAA_BLUE_COLOR),
                                              ),
                                            ),
                                            Text(
                                              "Car",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color:
                                                    Color(THEME.SAA_BLUE_COLOR),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    DineRewardCataloguePage()));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset:
                                                    Offset(0.0, 1.0), //(x,y)
                                                blurRadius: 6.0,
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.local_bar,
                                                size: 30,
                                                color:
                                                    Color(THEME.SAA_BLUE_COLOR),
                                              ),
                                            ),
                                            Text(
                                              "Dine",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color:
                                                    Color(THEME.SAA_BLUE_COLOR),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    CruiseRewardCataloguePage()));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset:
                                                    Offset(0.0, 1.0), //(x,y)
                                                blurRadius: 6.0,
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.directions_boat,
                                                size: 30,
                                                color:
                                                    Color(THEME.SAA_BLUE_COLOR),
                                              ),
                                            ),
                                            Text(
                                              "Cruise",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color:
                                                    Color(THEME.SAA_BLUE_COLOR),
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
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
