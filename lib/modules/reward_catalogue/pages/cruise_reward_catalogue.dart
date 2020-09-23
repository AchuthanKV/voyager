import 'package:flutter/material.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/modules/vouchers/pages/cruise_voucher.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class CruiseRewardCataloguePage extends StatefulWidget {
  CruiseRewardCataloguePage({Key key}) : super(key: key);

  @override
  _CruiseRewardCataloguePageState createState() =>
      _CruiseRewardCataloguePageState();
}

class _CruiseRewardCataloguePageState extends State<CruiseRewardCataloguePage> {
  @override
  Widget build(BuildContext context) {
    List cruisePictures = [
      "assets/images/non_air_cruises.png",
      /*
           "assets/images/uberlogo.png"*/
    ];

    List cruiseName = [
      "Cruises International",
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Rewards Catalogue'),
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
        body: Stack(children: [
          BackgroundClass(),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  child: Text(
                    "Cruise Reward",
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
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          height: 150,
                          child: Image.asset(cruisePictures[0]),
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 20, right: 20),
                                child: Text(
                                  cruiseName[0],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(THEME.PRIMARY_COLOR),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            IconsRewards(i: 0)
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

class IconsRewards extends StatefulWidget {
  int i;
  IconsRewards({Key key, this.i}) : super(key: key);

  @override
  _IconsRewardsState createState() => _IconsRewardsState();
}

class _IconsRewardsState extends State<IconsRewards>
    with TickerProviderStateMixin {
  double _scale1;
  double _scale2;
  AnimationController _controller1;
  AnimationController _controller2;

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
        context, new MaterialPageRoute(builder: (__) => CruiseVoucher()));
  }

  @override
  Widget build(BuildContext context) {
    _scale1 = 1 - _controller1.value;
    _scale2 = 1 - _controller2.value;

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
