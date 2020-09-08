import 'package:flutter/material.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/services/calls_and_message_service.dart';
import 'package:voyager/services/service_locator.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  final String mobileNumber = "0860003145";
  final String phoneNumber = "+2711 978 1234";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Contact Us'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false);
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/images/plainbackground.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment(0.0, 0.0),
                  height: 130.0,
                  margin: EdgeInsets.only(top: 40.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.fitHeight,
                  )),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Telephone-Within South Africa",
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: <Widget>[
                          inkWellSection(mobileNumber),
                          Text(
                            " (Share call)",
                          )
                        ]),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Telephone-Outside South Africa",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: <Widget>[
                          inkWellSection(phoneNumber),
                        ]),
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          //padding: EdgeInsets.only(left: 20),
                          child: Row(children: <Widget>[
                            Text(
                              "Operating Hours",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(children: <Widget>[
                            Text(
                              "Monday - Friday 07h00 to 21h00",
                            ),
                          ]),
                        ),
                        Container(
                          child: Row(children: <Widget>[
                            Text(
                              "Weekends and public holidays 08h00 to 14h00",
                            ),
                          ]),
                        ),
                      ]),
                ),
              ],
            )));
  }

  InkWell inkWellSection(String title) {
    return InkWell(
      child: Text(
        title,
        style: TextStyle(
            color: Color(THEME.PRIMARY_COLOR),
            decoration: TextDecoration.underline),
      ),
      onTap: () {
        makePhoneCall(title);
      },
    );
  }

  Future<void> makePhoneCall(String contactNumber) async {
    try {
      _service.call(contactNumber);
    } on Exception {
      throw 'Could not launch $contactNumber';
    }
  }
}
