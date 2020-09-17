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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Rewards & Vouchers'),
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
                            IconsRewards(i: 0)
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
                            IconsRewards(i: 1)
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
                            IconsRewards(i: 2)
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

class IconsRewards extends StatefulWidget {
  int i;
  IconsRewards({Key key, this.i}) : super(key: key);

  @override
  _IconsRewardsState createState() => _IconsRewardsState();
}

class _IconsRewardsState extends State<IconsRewards>
    with TickerProviderStateMixin {
  List<String> _dropdownValues;
  double _scale1;
  double _scale2;
  AnimationController _controller1;
  AnimationController _controller2;

  void _displayDialog(BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        return AlertDialog(
            contentPadding: EdgeInsets.only(top: 20, left: 40),
            titlePadding: EdgeInsets.only(top: 40, left: 30, right: 100),
            buttonPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            title: Text("Choose your trip type"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List<Widget>.generate(_dropdownValues.length,
                      (int index) {
                    return Row(
                      children: [
                        Radio<int>(
                          value: index,
                          groupValue: selectedRadio,
                          onChanged: (int value) {
                            setState(() => selectedRadio = value);
                          },
                        ),
                        Text(_dropdownValues[index])
                      ],
                    );
                  }),
                );
              },
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog

              new FlatButton(
                color: Color(THEME.BUTTON_COLOR),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: new Text("Add To Wishlist",
                    style: TextStyle(
                        color: Color(THEME.PRIMARY_COLOR), fontSize: 15)),
                onPressed: () {
                  Navigator.of(context).pop();
                  //Write code to add this trip to Wishlist
                },
              ),
            ]);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _scale1 = 0;
    _scale2 = 0;
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  Future<void> go1(BuildContext context) async {
    await new Future.delayed(const Duration(milliseconds: 200));
    _displayDialog(context, widget.i);
    setState(() {
      _controller1.value = 0;
    });
  }

  Future<void> go2(BuildContext context) async {
    await new Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      _controller2.value = 0;
    });
    Navigator.push(
        context, new MaterialPageRoute(builder: (__) => FlightVoucher()));
  }

  @override
  Widget build(BuildContext context) {
    _scale1 = 1 - _controller1.value;
    _scale2 = 1 - _controller2.value;
    switch (widget.i) {
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
    void _onTapDown1(TapDownDetails details) {
      _controller1.forward();
    }

    void _onTapUp1(TapUpDetails details) {
      _controller1.reverse();
    }

    void _onTapDown2(TapDownDetails details) {
      _controller2.forward();
    }

    void _onTapUp2(TapUpDetails details) {
      _controller2.reverse();
    }

    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTapDown: _onTapDown1,
            onTapUp: _onTapUp1,
            child: Transform.scale(
              scale: _scale1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: IconButton(
                    icon: Image.asset(
                      "assets/images/wishlist_round_1.png",
                      color: Color(THEME.PRIMARY_COLOR),
                    ),
                    onPressed: () {
                      go1(context);
                    }),
              ),
            ),
          ),
          GestureDetector(
            onTapDown: _onTapDown2,
            onTapUp: _onTapUp2,
            child: Transform.scale(
              scale: _scale2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: IconButton(
                    icon: Image.asset("assets/images/voucher_round.png",
                        color: Color(THEME.PRIMARY_COLOR)),
                    onPressed: () {
                      go2(context);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
