import 'package:chameleon/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  Future<void> go(BuildContext context) async {
    await new Future.delayed(const Duration(seconds: 3));
    Navigator.push(
        context, new MaterialPageRoute(builder: (__) => LoginPage()));
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
                    image: AssetImage('assets/images/saa2.jpg'),
                    fit: BoxFit.fill)),
          )),
      Positioned(
        top: 250,
        child: Text(
          "Welcome",
          style: GoogleFonts.dancingScript(
            textStyle: TextStyle(
                color: Colors.white, fontSize: 90.0, letterSpacing: 3),
          ),
        ),
      ),
      Positioned(
        top: 350,
        left: 30,
        child: Text(
          "to SAA Voyager ",
          style: GoogleFonts.dancingScript(
            textStyle: TextStyle(
                color: Colors.white, fontSize: 55.0, letterSpacing: 3),
          ),
        ),
      ),
    ]));
  }
}
