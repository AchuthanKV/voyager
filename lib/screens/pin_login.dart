import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pin_code_view/pin_code_view.dart';
import 'package:voyager/main.dart';
import 'package:voyager/services/background.dart';

class PinLogin extends StatefulWidget {
  PinLogin({Key key}) : super(key: key);

  @override
  _PinLoginState createState() => _PinLoginState();
}

class _PinLoginState extends State<PinLogin> {
  var pin = '0000';
  getPin() async {
    pin = await _storage.read(key: 'pin');
    if (pin == null) {
      pin = '0000';
    }
    return pin;
  }

  final _storage = FlutterSecureStorage();
  void initState() {
    super.initState();
    getPin();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          BackgroundClass(),
          Scaffold(
              appBar: AppBar(
                title: Text('Enter Pin'),
                backgroundColor: Colors.transparent,
              ),
              backgroundColor: Colors.transparent,
              body: PinCode(
                backgroundColor: Colors.transparent,
                title: Text(
                  "Lock Screen",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),

                subTitle: Text(
                  "",
                  style: TextStyle(color: Colors.white),
                ),
                codeLength: 4,
                // you may skip correctPin and plugin will give you pin as
                // call back of [onCodeFail] before it clears pin
                // correctPin: pin,
                onCodeFail: (code) {
                  if (code == pin) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()),
                        (Route<dynamic> route) => false);
                  }
                },
              )),
        ],
      ),
    );
  }
}
