import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:voyager/modules/login/pages/login_screen.dart';
import 'package:voyager/screens/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> go(BuildContext context) async {
    String membershipId = await _storage.read(key: 'membershipId');

    if (membershipId != null) {
      await new Future.delayed(const Duration(seconds: 3));
      Navigator.push(
          context, new MaterialPageRoute(builder: (__) => LoginScreen()));
    } else {
      await new Future.delayed(const Duration(seconds: 3));
      Navigator.push(
          context, new MaterialPageRoute(builder: (__) => LoginPage()));
    }
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
