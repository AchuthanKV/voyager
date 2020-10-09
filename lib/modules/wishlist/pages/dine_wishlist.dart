import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/base/models/wishlist_item_model.dart';
import 'package:voyager/base/utils/sizeconfig.dart';
import 'package:voyager/modules/vouchers/pages/dine_voucher.dart';
import 'package:voyager/modules/wishlist/pages/wishlist_home.dart';
import 'package:voyager/modules/wishlist/widgets/status_snackbar.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class DineWishlist extends StatefulWidget {
  DineWishlist({Key key}) : super(key: key);
  save(WishlistItemModel item) {
    createState().save(item);
  }

  @override
  _DineWishlistState createState() => _DineWishlistState();
}

class _DineWishlistState extends State<DineWishlist> {
  List<Map> wishList = [];
  List<WishlistItemModel> dineList = [];
  bool isLoading = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  go() {
    dineList = Wishlist.dineList;
    wishList = Wishlist.wishList;
    print(wishList.length.toString() + "wishlistttt");
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  delete(WishlistItemModel item) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await go();
    Map itemMap = {
      "category": item.category,
      "airAwardType": item.airAwardType,
      "airSearchType": item.airSearchType,
      "awardName": item.awardName,
      "awardPicture": item.awardPicture,
    };

    dineList.remove(item);

    int index = -1;
    wishList.forEach((element) async {
      if (element["awardName"] == itemMap['awardName']) {
        index = wishList.indexOf(element);

        return;
      }
    });

    wishList.removeAt(index);

    await sharedPreferences.setString("wishlist", json.encode(wishList));
    //delete alert
    WishlistStatus.displaySnackBar(_scaffoldKey, "Deleted Item from Wishlist!");
  }

  save(WishlistItemModel item) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(item.getAwardName + "gg");
    Map itemMap = {
      "category": item.category,
      "airAwardType": item.airAwardType,
      "airSearchType": item.airSearchType,
      "awardName": item.awardName,
      "awardPicture": item.awardPicture,
    };

    await go();
    //  print(flightList.length.toString() + "kjiu");
    bool present = false;
    wishList.forEach((element) {
      if (element["awardName"] == itemMap['awardName']) {
        present = true;
        return;
      }
    });
    if (present) {
      print('already there');
      return false;
    } else {
      wishList.add(itemMap);
      await sharedPreferences.setString("wishlist", json.encode(wishList));
      return true;
    }

    //  sharedPreferences.remove("wishlist");
  }

  @override
  Widget build(BuildContext context) {
    go();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Cruise Wishlist"),
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
            !isLoading
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                        child: dineList.length == 0
                            ? Center(
                                child: Text("No items in Wishlist!!"),
                              )
                            : GridView.count(
                                // Create a grid with 2 columns. If you change the scrollDirection to
                                // horizontal, this produces 2 rows.
                                childAspectRatio: 1.9,
                                crossAxisCount: 1,
                                // Generate 100 widgets that display their index in the List.
                                children:
                                    List.generate(dineList.length, (index) {
                                  return Center(
                                    child: Container(
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40))),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(5),
                                            child: Image.asset(
                                                dineList[index].awardPicture),
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30),
                                                    child: Text(
                                                      "${dineList[index].awardName}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color(THEME
                                                              .PRIMARY_COLOR),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        icon: Image.asset(
                                                            "assets/images/voucher_round.png",
                                                            color: Color(THEME
                                                                .PRIMARY_COLOR)),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (__) =>
                                                                      DineVoucher()));
                                                        }),
                                                    IconButton(
                                                        icon: Icon(
                                                          Icons.delete_forever,
                                                          color: Color(THEME
                                                              .PRIMARY_COLOR),
                                                        ),
                                                        onPressed: () {
                                                          delete(
                                                              dineList[index]);
                                                          //delete item
                                                        }),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              )),
                  )
                : Column(
                    children: [
                      Container(
                        height: SizeConfig.screenHeight / 3,
                        child: Center(
                          child: SpinKitCubeGrid(
                            color: Colors.black26,
                            size: 100.0,
                          ),
                        ),
                      ),
                      Text(
                        'Loading...!!',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  )
          ],
        ));
  }
}
