import 'package:flutter/material.dart';
import 'package:voyager/modules/vouchers/pages/flight_voucher.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class FlightRewardCataloguePage extends StatefulWidget {
  FlightRewardCataloguePage({Key key}) : super(key: key);

  @override
  _FlightRewardCataloguePageState createState() =>
      _FlightRewardCataloguePageState();
}

class _FlightRewardCataloguePageState extends State<FlightRewardCataloguePage> {
  @override
  Widget build(BuildContext context) {
    List airName = ["SA Airlink", "SAA Awards", "SA Express", "Star Alliance"];

    List airAwardType = [
      "Anyday / MileageKeeper",
      "Upgrade Awards",
      "MileageKeeper / K-Keeper",
      ""
    ];
    List airSearchType = [
      "OneWay / Round Trip",
      "One Way",
      "OneWay / Round Trip",
      "Round Trip"
    ];
    List airPictures = [
      "assets/images/sa_airlink.jpg",
      "assets/images/saa_starallianz.png",
      "assets/images/saa_express.png",
      "assets/images/alliance_reward.png"
    ];

    String _value;

    void _displayDialog(BuildContext context, int index) async {
      List<String> _dropdownValues;
      switch (index) {
        case 0:
          _dropdownValues = [
            "Oneway",
            "Round Trip",
          ];
          break;
        case 1:
          _dropdownValues = [
            "Oneway",
          ];
          break;
        case 2:
          _dropdownValues = [
            "Oneway",
            "Round Trip",
          ];
          break;
        default:
      }

      _value = "Choose Type";
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: DropdownButton(
                  items: _dropdownValues
                      .map((value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (String value) {
                    setState(() {
                      _value = value;
                    });
                    print(value);
                    Navigator.of(context).pop();
                    //Here write code for adding value to wishlist
                  },
                  isExpanded: true,
                  hint: Text("Choose your search type")),
            );
          });
    }

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
      body: Stack(
        children: [
          BackgroundClass(),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  child: Text(
                    "Air Rewards",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(THEME.PRIMARY_COLOR)),
                  ),
                )),
                Container(
                  height: 180,
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
                        child: Image.asset(airPictures[0]),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  airName[0],
                                  style: TextStyle(
                                      color: Color(THEME.PRIMARY_COLOR),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            Text(
                              airAwardType[0],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              airSearchType[0],
                              style: TextStyle(
                                  color: Color(THEME.PRIMARY_COLOR),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 5),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Image.asset(
                                        "assets/images/wishlist_round_1.png",
                                        color: Colors.indigo[900],
                                      ),
                                      onPressed: () {
                                        _displayDialog(context, 0);
                                      }),
                                  IconButton(
                                      icon: Image.asset(
                                          "assets/images/voucher_round.png",
                                          color: Colors.indigo[900]),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (__) =>
                                                    FlightVoucher()));
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
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Image.asset(airPictures[1]),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  airName[1],
                                  style: TextStyle(
                                      color: Color(THEME.PRIMARY_COLOR),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            Text(
                              airAwardType[1],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              airSearchType[1],
                              style: TextStyle(
                                  color: Color(THEME.PRIMARY_COLOR),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 5),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Image.asset(
                                        "assets/images/wishlist_round_1.png",
                                        color: Colors.indigo[900],
                                      ),
                                      onPressed: () {
                                        _displayDialog(context, 1);
                                      }),
                                  IconButton(
                                      icon: Image.asset(
                                          "assets/images/voucher_round.png",
                                          color: Colors.indigo[900]),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (__) =>
                                                    FlightVoucher()));
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
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 150,
                        child: Image.asset(airPictures[3]),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  airName[3],
                                  style: TextStyle(
                                      color: Color(THEME.PRIMARY_COLOR),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            Text(
                              airAwardType[2],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              airSearchType[0],
                              style: TextStyle(
                                  color: Color(THEME.PRIMARY_COLOR),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 5),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Image.asset(
                                        "assets/images/wishlist_round_1.png",
                                        color: Colors.indigo[900],
                                      ),
                                      onPressed: () {
                                        _displayDialog(context, 2);
                                      }),
                                  IconButton(
                                      icon: Image.asset(
                                          "assets/images/voucher_round.png",
                                          color: Colors.indigo[900]),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (__) =>
                                                    FlightVoucher()));
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
        ],
      ),
    );
  }
}
