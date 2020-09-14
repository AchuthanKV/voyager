import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/base/models/account_model.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/services/background.dart';

class RsgisteredDetails extends StatelessWidget {
  const RsgisteredDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileModel profileObject = LoginUser.profileModel;
    AccountModel accountModel = LoginUser.accountModel;
    return Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            BackgroundClass(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey[300],
                  height: 50,
                  child: Center(
                      child: Text(
                    "Registration  Details ",
                    style: TextStyle(fontSize: 20),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "${profileObject.title} ${profileObject.givenName} ${profileObject.familyName}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Mobile Number',
                        style: TextStyle(fontSize: 16),
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Text(":"),
                      ),
                      Expanded(
                          child: Text(
                        "${profileObject.phoneISDCode}${profileObject.phoneNumber}",
                        style: TextStyle(fontSize: 16),
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Email Address',
                        style: TextStyle(fontSize: 16),
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Text(":"),
                      ),
                      Expanded(
                          child: Text(
                        "${profileObject.emailAddress}",
                        style: TextStyle(fontSize: 16),
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Date of Birth',
                        style: TextStyle(fontSize: 16),
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Text(":"),
                      ),
                      Expanded(
                          child: Text(
                        "${profileObject.dateOfBirth}",
                        style: TextStyle(fontSize: 16),
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Gender',
                        style: TextStyle(fontSize: 16),
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Text(":"),
                      ),
                      Expanded(
                        child: (profileObject.gender == "m")
                            ? Text(
                                "Male",
                                style: TextStyle(fontSize: 16),
                              )
                            : Text(
                                "Female",
                                style: TextStyle(fontSize: 16),
                              ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Country',
                        style: TextStyle(fontSize: 16),
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Text(":"),
                      ),
                      Expanded(
                          child: Text(
                        "${profileObject.country}",
                        style: TextStyle(fontSize: 16),
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Passport Number',
                        style: TextStyle(fontSize: 16),
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Text(":"),
                      ),
                      Expanded(
                          child: Text(
                        "${profileObject.passportNumber}",
                        style: TextStyle(fontSize: 16),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
