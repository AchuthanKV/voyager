import 'package:flutter/material.dart';
import 'package:voyager/base/models/wishlist_item_model.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/modules/vouchers/pages/car_voucher.dart';
import 'package:voyager/modules/wishlist/pages/car_wishlist.dart';
import 'package:voyager/modules/wishlist/widgets/status_snackbar.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class CarRewardCataloguePage extends StatefulWidget {
  CarRewardCataloguePage({Key key}) : super(key: key);
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

  @override
  _CarRewardCataloguePageState createState() => _CarRewardCataloguePageState();
}

class _CarRewardCataloguePageState extends State<CarRewardCataloguePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
                          child: Image.asset(widget.carPictures[0]),
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  widget.carName[0],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(THEME.PRIMARY_COLOR),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            IconsRewards(i: 0, scaffoldKey: _scaffoldKey)
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
                        child: Image.asset(widget.carPictures[1]),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Text(
                                  widget.carName[1],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(THEME.PRIMARY_COLOR),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            IconsRewards(i: 1, scaffoldKey: _scaffoldKey)
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
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  IconsRewards({Key key, this.i, this.scaffoldKey}) : super(key: key);
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
        context, new MaterialPageRoute(builder: (__) => CarVoucher()));
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
                    onPressed: () async {
                      go1(context);
                      bool status = false;
                      print("pressed save");
                      status = await CarWishlist().save(new WishlistItemModel(
                        "car",
                        CarRewardCataloguePage().carName[widget.i],
                        CarRewardCataloguePage().carPictures[widget.i],
                        "",
                        "",
                      ));
                      if (!status) {
                        WishlistStatus.displaySnackBar(
                            widget.scaffoldKey, "Already there in wishlist");
                      } else {
                        WishlistStatus.displaySnackBar(
                            widget.scaffoldKey, "Added to  wishlist");
                      }
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
