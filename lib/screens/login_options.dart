import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:voyager/services/background.dart';

class LoginOptions extends StatefulWidget {
  LoginOptions({Key key}) : super(key: key);
  bool isInstructionView = false;

  @override
  _LoginOptionsState createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  String usingBio = "false";
  final _storage = FlutterSecureStorage();
  LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Scan your Fingerprint to authenticate",
          useErrorDialogs: true,
          stickyAuth: true);
      _storage.write(key: 'biometric', value: 'true');
    } on PlatformException catch (e) {
      print("Exception $e");
    }

    return authenticated;
  }

  @override
  Widget build(BuildContext context) {
    getStoredVal();
    return Stack(
      children: <Widget>[
        BackgroundClass(),
        Scaffold(
          appBar: AppBar(
            title: Text('Login Options'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.lock_outline,
                    color: Colors.white70,
                    size: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Enable Fingerprint',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Switch(
                        value: widget.isInstructionView,
                        onChanged: (bool isOn) {
                          setState(() {
                            widget.isInstructionView = isOn;
                          });
                          if (isOn == true) {
                            _authenticate();
                          } else {
                            setStoredVal();
                          }
                        },
                        activeColor: Colors.yellow[100],
                        inactiveTrackColor: Colors.white70,
                        inactiveThumbColor: Colors.white70,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  setStoredVal() async {
    await _storage.write(key: 'biometric', value: 'false');
    setState(() {
      usingBio = usingBio;
      widget.isInstructionView = false;
    });
  }

  getStoredVal() async {
    usingBio = await (_storage.read(key: 'biometric'));
    if (usingBio == 'false') {
      setState(() {
        usingBio = usingBio;
        widget.isInstructionView = false;
      });
    } else {
      setState(() {
        usingBio = usingBio;
        widget.isInstructionView = true;
      });
    }
  }
}
