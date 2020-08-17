import 'package:voyager/modules/login/pages/login_screen.dart';
import 'package:voyager/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  Future<void> go(BuildContext context) async {
    await new Future.delayed(const Duration(seconds: 3));
    Navigator.push(
        context, new MaterialPageRoute(builder: (__) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    go(context);
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          height: double.infinity,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/splash.png'),
                    fit: BoxFit.fill)),
          )),
    ]));
  }
}
