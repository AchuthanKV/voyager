import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/modules/login/pages/login_screen.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class Logout {
  static removeSharedPreferenceKeys() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  static showAlertDialog(BuildContext context) {
    Widget yesButton = FlatButton(
      color: Color(THEME.BUTTON_COLOR),
      child: new Text("Yes", style: TextStyle(color: Colors.black)),
      onPressed: () {
        removeSharedPreferenceKeys();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
            (Route<dynamic> route) => false);
      },
    );

    Widget noButton = FlatButton(
      color: Color(THEME.BUTTON_COLOR),
      child: new Text("No", style: TextStyle(color: Colors.black)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    Dialog alert = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      // title: Text("Log Out", style: TextStyle(color: Colors.black)),
      // content: Text("Do you want to log out ?",
      //     style: TextStyle(color: Colors.black)),
      // actions: [
      //   noButton,
      //   yesButton,
      // ],
      child: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text("Log Out",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Do you want to log out ?",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [noButton, yesButton],
            )
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
