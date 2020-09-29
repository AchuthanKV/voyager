import 'package:flutter/material.dart';
import 'package:voyager/modules/contactus/pages/contact_us.dart';
import 'package:voyager/modules/login/pages/login_screen.dart';
import 'package:voyager/modules/logout/pages/logout.dart';
import 'package:voyager/modules/voyager_partners/pages/display_partner_site.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;
import 'package:voyager/base/utils/sizeconfig.dart';
import 'package:flutter/cupertino.dart';

class HotelPartner extends StatefulWidget {
  HotelPartner({Key key}) : super(key: key);

  @override
  _HotelPartnerState createState() => _HotelPartnerState();
}

class _HotelPartnerState extends State<HotelPartner> {
  List items = [
    "bestlarge.png",
    "HHonors.jpg",
    "IHG.jpg",
    "marriotlarge.jpg",
    "radissonlarge.jpg",
    "rocketmileslarge.jpg",
    "shangri.jpg"
  ];

  List routingPath = [null, null, null, null, null, null, null];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Voyager Partners'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              //notifictn pg
            },
            child: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          BackgroundClass(),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Hotel Rewards",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(THEME.PRIMARY_COLOR)),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  child: Text(
                    "Miles can be claimed via the voyager Service Centre",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 28,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 2.5,
                      shrinkWrap: true,
                      children: List.generate(
                        items.length,
                        (index) {
                          return Container(
                            color: Colors.transparent,
                            child: PartnerNameCard(
                                items[index], routingPath[index]),
                          );
                        },
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CarPartner extends StatefulWidget {
  CarPartner({Key key}) : super(key: key);

  @override
  _CarPartnerState createState() => _CarPartnerState();
}

class _CarPartnerState extends State<CarPartner> {
  List items = [
    "Avis1.jpg",
    "eurolarge.jpg",
  ];

  List routingPath = [null, DisplayPartnerSite(i: 0)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Voyager Partners'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              //notifictn pg
            },
            child: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          BackgroundClass(),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Car Rewards",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(THEME.PRIMARY_COLOR)),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  child: Text(
                    "Miles can be claimed via the voyager Service Centre",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 28,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 2.5,
                      shrinkWrap: true,
                      children: List.generate(
                        items.length,
                        (index) {
                          return Container(
                            color: Colors.transparent,
                            child: PartnerNameCard(
                                items[index], routingPath[index]),
                          );
                        },
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DinePartner extends StatefulWidget {
  DinePartner({Key key}) : super(key: key);

  @override
  _DinePartnerState createState() => _DinePartnerState();
}

class _DinePartnerState extends State<DinePartner> {
  List items = [
    "healthlarge.jpg",
    "wine.jpg",
    "dinepartner5.jpg",
    "netflorist.jpg"
  ];

  List routingPath = [null, null, null, DisplayPartnerSite(i: 1)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Voyager Partners'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              //notifictn pg
            },
            child: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          BackgroundClass(),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Dine Rewards",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(THEME.PRIMARY_COLOR)),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  child: Text(
                    "Miles can be claimed via the voyager Service Centre",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 28,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 2.5,
                      shrinkWrap: true,
                      children: List.generate(
                        items.length,
                        (index) {
                          return Container(
                            color: Colors.transparent,
                            child: PartnerNameCard(
                                items[index], routingPath[index]),
                          );
                        },
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CruisePartner extends StatefulWidget {
  CruisePartner({Key key}) : super(key: key);

  @override
  _CruisePartnerState createState() => _CruisePartnerState();
}

class _CruisePartnerState extends State<CruisePartner> {
  List items = ["cruiselarge.jpg"];

  List routingPath = [null];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Voyager Partners'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              //notifictn pg
            },
            child: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          BackgroundClass(),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Cruise Rewards",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(THEME.PRIMARY_COLOR)),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  child: Text(
                    "Miles can be claimed via the voyager Service Centre",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 28,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 2.5,
                      shrinkWrap: true,
                      children: List.generate(
                        items.length,
                        (index) {
                          return Container(
                            color: Colors.transparent,
                            child: PartnerNameCard(
                                items[index], routingPath[index]),
                          );
                        },
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CardPartner extends StatefulWidget {
  CardPartner({Key key}) : super(key: key);

  @override
  _CardPartnerState createState() => _CardPartnerState();
}

class _CardPartnerState extends State<CardPartner> {
  List items = [
    "voyager_premium_credit.png",
    "voyager_premium_cheque.png",
    "ecolarge.jpg",
    "nedbanklogo.png",
    "unico.png"
  ];

  List routingPath = [
    DisplayPartnerSite(i: 2),
    DisplayPartnerSite(i: 3),
    null,
    null,
    null
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Voyager Partners'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              //notifictn pg
            },
            child: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          BackgroundClass(),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Cards",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(THEME.PRIMARY_COLOR)),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  child: Text(
                    "Miles can be claimed via the voyager Service Centre",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 28,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 2.5,
                      shrinkWrap: true,
                      children: List.generate(
                        items.length,
                        (index) {
                          return Container(
                            color: Colors.transparent,
                            child: PartnerNameCard(
                                items[index], routingPath[index]),
                          );
                        },
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PartnerNameCard extends StatefulWidget {
  String items;
  Widget routingPath;
  PartnerNameCard(this.items, this.routingPath, {Key key}) : super(key: key);

  @override
  _PartnerNameCardState createState() => _PartnerNameCardState();
}

class _PartnerNameCardState extends State<PartnerNameCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
            onPressed: () {
              if (widget.routingPath != null) {
                if (widget.items == "netflorist.jpg") {
                  showAlertDialog(context, widget.routingPath);
                } else
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => widget.routingPath));
              }
            },
            child: Image.asset("assets/images/" + widget.items)),
        widget.items == "voyager_premium_credit.png"
            ? Text(
                "Voyager Credit Card South Africa",
                style: TextStyle(fontSize: 11),
              )
            : widget.items == "voyager_premium_cheque.png"
                ? Text(
                    "Voyager Cheque Card South Africa",
                    style: TextStyle(fontSize: 11),
                  )
                : Container(
                    height: 0,
                  ),
      ],
    );
  }

  static showAlertDialog(BuildContext context, Widget routingPath) {
    String msg =
        "Sending flowers and gifts anywhere in South Africa has never been easier! NetFlorist has hubs situated in all major cities across the country, and also deliver countrywide through a network of preferred florists and courier services around South Africa as well as internationally. Visit www.netflorist.co.za and pay with your Voyager Miles";

    Widget yesButton = FlatButton(
      color: Color(THEME.BUTTON_COLOR),
      child: new Text("Visit", style: TextStyle(color: Colors.black)),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => routingPath));
      },
    );

    Widget noButton = FlatButton(
      color: Color(THEME.BUTTON_COLOR),
      child: new Text("Cancel", style: TextStyle(color: Colors.black)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    Dialog alert = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  msg,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [noButton, yesButton],
            )
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
