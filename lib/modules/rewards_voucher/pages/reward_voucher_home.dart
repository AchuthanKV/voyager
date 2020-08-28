import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/services.dart';
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
              width: double.infinity,
              height: double.infinity,
              //margin: EdgeInsets.all(10),
              //padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 200),
                          child: Text(
                            "Reward Catalogue",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(THEME.PRIMARY_COLOR)),
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
                                    onPressed: () {},
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
                                      width: 130,
                                      height: 100,
                                      //padding: EdgeInsets.all(30),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(
                                              Icons.flight,
                                              size: 30,
                                              color: Color(THEME.PRIMARY_COLOR),
                                            ),
                                          ),
                                          Text(
                                            "Flight",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(THEME.PRIMARY_COLOR),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {},
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
                                      width: 130,
                                      height: 100,
                                      //padding: EdgeInsets.all(30),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(
                                              Icons.directions_car,
                                              size: 30,
                                              color: Color(THEME.PRIMARY_COLOR),
                                            ),
                                          ),
                                          Text(
                                            "Car",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(THEME.PRIMARY_COLOR),
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
                                    onPressed: () {},
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
                                      width: 130,
                                      height: 100,
                                      //padding: EdgeInsets.all(30),
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(
                                              Icons.local_bar,
                                              size: 30,
                                              color: Color(THEME.PRIMARY_COLOR),
                                            ),
                                          ),
                                          Text(
                                            "Dine",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(THEME.PRIMARY_COLOR),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {},
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
                                      width: 130,
                                      height: 100,
                                      //padding: EdgeInsets.all(30),
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(
                                              Icons.directions_boat,
                                              size: 30,
                                              color: Color(THEME.PRIMARY_COLOR),
                                            ),
                                          ),
                                          Text(
                                            "Cruise",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(THEME.PRIMARY_COLOR),
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
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 250),
                          child: Text(
                            "Vouchers",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(THEME.PRIMARY_COLOR)),
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
                                    onPressed: () {},
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
                                      width: 130,
                                      height: 100,
                                      //padding: EdgeInsets.all(30),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(
                                              Icons.flight,
                                              size: 30,
                                              color: Color(THEME.PRIMARY_COLOR),
                                            ),
                                          ),
                                          Text(
                                            "Flight",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(THEME.PRIMARY_COLOR),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {},
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
                                      width: 130,
                                      height: 100,
                                      //padding: EdgeInsets.all(30),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(
                                              Icons.directions_car,
                                              size: 30,
                                              color: Color(THEME.PRIMARY_COLOR),
                                            ),
                                          ),
                                          Text(
                                            "Car",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(THEME.PRIMARY_COLOR),
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
                                    onPressed: () {},
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
                                      width: 130,
                                      height: 100,
                                      //padding: EdgeInsets.all(30),
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(
                                              Icons.local_bar,
                                              size: 30,
                                              color: Color(THEME.PRIMARY_COLOR),
                                            ),
                                          ),
                                          Text(
                                            "Dine",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(THEME.PRIMARY_COLOR),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {},
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
                                      width: 130,
                                      height: 100,
                                      //padding: EdgeInsets.all(30),
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(
                                              Icons.directions_boat,
                                              size: 30,
                                              color: Color(THEME.PRIMARY_COLOR),
                                            ),
                                          ),
                                          Text(
                                            "Cruise",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(THEME.PRIMARY_COLOR),
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
                        )
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
