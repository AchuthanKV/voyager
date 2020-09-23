import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:voyager/modules/vouchers/pages/cruise_voucher.dart';
import 'package:voyager/modules/reward_catalogue/pages/car_reward_catalogue.dart';
import 'package:voyager/modules/reward_catalogue/pages/cruise_reward_catalogue.dart';
import 'package:voyager/modules/reward_catalogue/pages/dine_reward_catalogue.dart';
import 'package:voyager/modules/vouchers/pages/dine_voucher.dart';
import 'package:voyager/modules/reward_catalogue/pages/flight_reward_catalogue.dart';
import 'package:voyager/modules/vouchers/pages/flight_voucher.dart';
import 'package:voyager/modules/vouchers/pages/car_voucher.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class RewardVoucherScreen extends StatefulWidget {
  RewardVoucherScreen({Key key}) : super(key: key);

  @override
  _RewardVoucherScreenState createState() => _RewardVoucherScreenState();
}

class _RewardVoucherScreenState extends State<RewardVoucherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 200, bottom: 30, top: 20),
                          child: Text(
                            "Reward Catalogue",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(THEME.SAA_BLUE_COLOR)),
                          ),
                        ),
                        Container(
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
                                              builder: (BuildContext context) =>
                                                  FlightRewardCataloguePage()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0.0, 1.0), //(x,y)
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
                                            padding: const EdgeInsets.all(15.0),
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
                                              builder: (BuildContext context) =>
                                                  CarRewardCataloguePage()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0.0, 1.0), //(x,y)
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
                                            padding: const EdgeInsets.all(15.0),
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
                                              builder: (BuildContext context) =>
                                                  DineRewardCataloguePage()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0.0, 1.0), //(x,y)
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
                                            padding: const EdgeInsets.all(15.0),
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
                                              builder: (BuildContext context) =>
                                                  CruiseRewardCataloguePage()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0.0, 1.0), //(x,y)
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
                                            padding: const EdgeInsets.all(15.0),
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
