import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/base/models/account_model.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/base/utils/sizeconfig.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/modules/my-profile/pages/address.dart';
import 'package:voyager/modules/my-profile/pages/registered_details.dart';
import 'package:voyager/modules/my-profile/widgets/add_image_dialog.dart';
import 'package:voyager/services/background.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  ProfileModel profileObject = LoginUser.profileModel;
  AccountModel accountModel = LoginUser.accountModel;

  SizeConfig sizeConfig = SizeConfig();
  String gender;
  go() {
    gender = profileObject.gender;
    gender = gender.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    go();
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("My Profile"),
          ),
          body: Stack(
            children: [
              BackgroundClass(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
                        child: FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => imageDialog);
                          },
                          child: (gender == 'm')
                              ? Image.asset(
                                  "assets/images/male.png",
                                  width: SizeConfig.screenWidth / 4 + 10,
                                )
                              : Image.asset(
                                  "assets/images/female.png",
                                  width: SizeConfig.screenWidth / 4 + 10,
                                ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: SizeConfig.screenWidth / 2,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${profileObject.title} ${profileObject.givenName} ${profileObject.familyName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth / 2,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${profileObject.tierName} Tier",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          color: Colors.grey[600],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Membership No:",
                                  style: TextStyle(color: Colors.white)),
                              Text("${profileObject.membershipId}",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          color: Colors.grey[900],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Tier Expiry",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text("${accountModel.getTierValidityDate}",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          color: Colors.grey[600],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Miles balance",
                                  style: TextStyle(color: Colors.white)),
                              Text("${accountModel.getPoints}",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  FlatButton(
                    color: Colors.grey[100],
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RsgisteredDetails()));
                    },
                    child: Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: [
                            Expanded(child: Text("Registered details")),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    color: Colors.grey[300],
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Address()));
                    },
                    child: Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: [
                            Expanded(child: Text("Address")),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
