import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/services/calls_and_message_service.dart';
import 'package:voyager/services/service_locator.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class MilesInfoPage extends StatefulWidget {
  @override
  _MilesInfoPageState createState() => _MilesInfoPageState();
}

class _MilesInfoPageState extends State<MilesInfoPage> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  final String phoneNumber = "+2719781234";
  final String sharePhoneNumber = "+27860003145";
  final String emailId = "voyager@flysaa.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Claim Miles'),
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
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/images/plainbackground.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(children: <Widget>[
              Text(
                'Miles can be claimed via the Voyager Service Center.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    " Email:  ",
                  ),
                  inkWellSection(emailId),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    " Phone Number:  ",
                  ),
                  inkWellSection(phoneNumber),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    " Share call:  ",
                  ),
                  inkWellSection(sharePhoneNumber),
                ],
              )
            ])));
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
        makePhoneCallEmail(title);
      },
    );
  }

  Future<void> makePhoneCallEmail(String milesInfo) async {
    try {
      if (milesInfo == emailId) {
        _service.sendEmail(milesInfo);
      } else {
        _service.call(milesInfo);
      }
    } on Exception {
      throw 'Could not launch $milesInfo';
    }
  }
}
