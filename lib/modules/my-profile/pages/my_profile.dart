import 'dart:convert';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/base/models/account_model.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/base/utils/sizeconfig.dart';
import 'package:voyager/modules/home/pages/landing_home_page.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/modules/my-profile/pages/address.dart';
import 'package:voyager/modules/my-profile/pages/registered_details.dart';
import 'package:voyager/modules/my-profile/widgets/add_image_dialog.dart';
import 'package:voyager/services/background.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key key}) : super(key: key);
  static bool hasImage = false;
  getPath() {
    return createState().getImagePath();
  }

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  ProfileModel profileObject = LoginUser.profileModel;
  AccountModel accountModel = LoginUser.accountModel;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  SizeConfig sizeConfig = SizeConfig();

  Future<File> _image;
  final picker = ImagePicker();
  String imagePath = "";
  String gender;
  String imageVal = "";
  @override
  void initState() {
    super.initState();
    gender = profileObject.gender;
    gender = gender.toLowerCase();
    getImagePath();
  }

  getImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await prefs.containsKey("profileImage")) {
      imagePath = await prefs.getString("profileImage");
      // print(imagePath + "gooooooo");
      if (mounted) {
        setState(() {
          MyProfile.hasImage = true;
        });
      } else {
        MyProfile.hasImage = true;
      }
    } else {
      imagePath = "";
      MyProfile.hasImage = false;
    }
    return imagePath;
  }

  saveImagePath(imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(imagePath + "savvveeee");
    await prefs.setString("profileImage", imagePath);
    LandingPage.proPicUrl = imagePath;
    getImagePath();
  }

  deleteImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await prefs.containsKey("profileImage")) {
      await prefs.remove("profileImage");
    }
    LandingPage.profilePic = false;
    setState(() {
      MyProfile.hasImage = false;
    });
  }

  Widget showPhoto() {
    print(imagePath + "jhuhu");
    return ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Image.file(
          File(imagePath),
          height: SizeConfig.screenWidth / 4,
          width: SizeConfig.screenWidth / 4,
          fit: BoxFit.fitWidth,
        ));
  }

  _takePhoto() async {
    try {
      ImagePicker.pickImage(source: ImageSource.camera)
          .then((File recordedImage) {
        if (recordedImage != null && recordedImage.path != null) {
          GallerySaver.saveImage(recordedImage.path).then((path) {
            // save path
            saveImagePath(recordedImage.path);

            setState(() {
              imagePath = recordedImage.path;
              MyProfile.hasImage = true;
            });
            showPhoto();
          });
        } else {
          print("nooo recordr img");
        }
      });
    } on Exception catch (e) {
      print("take photo exception");
    }
  }

  _selectPhoto() async {
    try {
      ImagePicker.pickImage(source: ImageSource.gallery)
          .then((File recordedImage) {
        if (recordedImage != null && recordedImage.path != null) {
          GallerySaver.saveImage(recordedImage.path).then((path) {
            // save path
            saveImagePath(recordedImage.path);

            setState(() {
              imagePath = recordedImage.path;
              MyProfile.hasImage = true;
            });
            showPhoto();
          });
        } else {
          print("nooo recordr img");
        }
      });
    } on Exception catch (e) {
      print("select photo exceptiomn");
    }
  }

  @override
  Widget build(BuildContext context) {
    Container image = Container(
      child: (gender == 'm')
          ? Image.asset(
              "assets/images/male.png",
              width: SizeConfig.screenWidth / 4 + 10,
            )
          : Image.asset(
              "assets/images/female.png",
              width: SizeConfig.screenWidth / 4 + 10,
            ),
    );

    dialogPop() {
      showDialog(
          context: _scaffoldkey.currentContext,
          builder: (_) {
            return Dialog(
              child: Container(
                color: Colors.white,
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FlatButton(
                          onPressed: () async {
                            await _takePhoto();

                            Navigator.pop(context);
                          },
                          child: Text(
                            'Take Picture',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                          ),
                        ),
                        FlatButton(
                          onPressed: () async {
                            await _selectPhoto();
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Select Picture form Gallery',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                          ),
                        ),
                        MyProfile.hasImage
                            ? FlatButton(
                                onPressed: () async {
                                  await deleteImagePath();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Remove Picture',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.0),
                                ),
                              )
                            : SizedBox(
                                height: 0,
                              ),
                      ],
                    )),
              ),
            );
          });
    }

    return Container(
      child: Scaffold(
          key: _scaffoldkey,
          appBar: AppBar(
            title: Text("My Profile"),
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
                        child: FlatButton(
                            onPressed: () {
                              dialogPop();
                            },
                            child: MyProfile.hasImage ? showPhoto() : image),
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
