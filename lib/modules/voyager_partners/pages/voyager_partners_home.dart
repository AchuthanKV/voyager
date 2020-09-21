import 'package:flutter/material.dart';
import 'package:voyager/modules/voyager_partners/pages/air_partners.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class VoyagerPartnersHome extends StatefulWidget {
  VoyagerPartnersHome({Key key}) : super(key: key);

  @override
  _VoyagerPartnersHomeState createState() => _VoyagerPartnersHomeState();
}

class _VoyagerPartnersHomeState extends State<VoyagerPartnersHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundClass(),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 200, top: 10),
                        child: Text(
                          "Voyager Partners",
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
                                offset: Offset(0.0, 1.0),
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
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CardsPartner(i: 0),
                                CardsPartner(i: 1)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CardsPartner(i: 2),
                                CardsPartner(i: 3)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CardsPartner(i: 4),
                                CardsPartner(i: 5)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CardsPartner extends StatefulWidget {
  int i;
  CardsPartner({Key key, this.i}) : super(key: key);

  @override
  _CardsPartnerState createState() => _CardsPartnerState();
}

class _CardsPartnerState extends State<CardsPartner> {
  List partnerType = ["Flight", "Hotel", "Car", "Dine", "Cruise", "Cards"];
  List patnerTypeIcon = [
    Icons.flight,
    Icons.location_city,
    Icons.directions_car,
    Icons.local_bar,
    Icons.directions_boat
  ];

  List patnerPages = [AirPartners()];
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        if (widget.i == 0)
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => patnerPages[widget.i]));
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
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: widget.i != 5
                  ? Icon(
                      patnerTypeIcon[widget.i],
                      size: 30,
                      color: Color(THEME.PRIMARY_COLOR),
                    )
                  : ImageIcon(
                      AssetImage("assets/images/claimmiles.png"),
                      size: 25,
                      color: Color(THEME.PRIMARY_COLOR),
                    ),
            ),
            Text(
              partnerType[widget.i],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(THEME.PRIMARY_COLOR),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
