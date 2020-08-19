import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class LoginOptions extends StatefulWidget {
  LoginOptions({Key key}) : super(key: key);
  bool isfingerprintOn = false;
  bool isPinOn = false;

  @override
  _LoginOptionsState createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  String usingBio = "false";
  bool pinSet = false;
  final _storage = FlutterSecureStorage();
  LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Scan your Fingerprint to authenticate",
          useErrorDialogs: true,
          stickyAuth: true);
      if (authenticated == true) {
        _storage.write(key: 'biometric', value: 'true');
      }
    } on PlatformException catch (e) {
      auth.stopAuthentication();
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
              child: Wrap(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Center(
                      child: Icon(
                        Icons.lock_outline,
                        color: Colors.white70,
                        size: 80,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 50),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          'Enable Fingerprint',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Switch(
                        value: widget.isfingerprintOn,
                        onChanged: (bool isOn) {
                          setState(() {
                            widget.isfingerprintOn = isOn;
                          });
                          if (isOn == true) {
                            _authenticate();
                          } else {
                            setStoredVal();
                            // show popup
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return AlertDialog(
                            //         backgroundColor: Colors.white70,
                            //         title: Text("Fingerprint",
                            //             style: TextStyle(
                            //                 color: Color(THEME.PRIMARY_COLOR))),
                            //         content: Text("The Fingerprint is Disabled",
                            //             style: TextStyle(
                            //                 color: Color(
                            //                     THEME.QUATERNARY_COLOUR))),
                            //       );
                            //     });
                          }
                        },
                        activeColor: Colors.green,
                        inactiveTrackColor: Colors.grey,
                        inactiveThumbColor: Colors.redAccent,
                        activeTrackColor: Colors.green,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 50),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          'Enable Pin',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Switch(
                        value: widget.isPinOn,
                        onChanged: (bool isOn) async {
                          setState(() {
                            widget.isPinOn = isOn;
                          });
                          if (isOn == true) {
                            await Navigator.pushNamed(context, '/setPin');
                            var pin = await _storage.read(key: 'pin');

                            if (pin != null) {
                              widget.isPinOn = true;
                            } else {
                              widget.isPinOn = false;
                            }
                          } else if (isOn == false) {
                            await _storage.delete(key: 'pin');
                          }
                        },
                        activeColor: Colors.green,
                        inactiveTrackColor: Colors.grey,
                        inactiveThumbColor: Colors.redAccent,
                        activeTrackColor: Colors.green,
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
      widget.isfingerprintOn = false;
    });
  }

  getStoredVal() async {
    var pin = await _storage.read(key: 'pin');

    if (pin != null) {
      setState(() {
        widget.isPinOn = true;
      });
    }

    usingBio = await (_storage.read(key: 'biometric'));
    if (usingBio == 'true') {
      setState(() {
        usingBio = usingBio;
        widget.isfingerprintOn = true;
      });
    } else {
      setState(() {
        usingBio = usingBio;
        widget.isfingerprintOn = false;
      });
    }
  }
}
