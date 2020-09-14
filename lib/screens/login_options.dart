import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class LoginOptions extends StatefulWidget {
  LoginOptions({Key key}) : super(key: key);
  bool isfingerprintOn = false;

  @override
  _LoginOptionsState createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  String usingBio = "false";

  final _storage = FlutterSecureStorage();
  LocalAuthentication auth = LocalAuthentication();

  String biometric = 'biometric';
  List<BiometricType> biometrics;

  bool isAndroid() {
    bool isAndroid = true;
    if (biometrics.contains(BiometricType.face)) {
      isAndroid = false;
      biometric = 'Face id';
    } else if (biometrics.contains(BiometricType.fingerprint)) {
      isAndroid = true;
      biometric = 'Fingerprint';
    }
    return isAndroid;
  }

  Future<List<BiometricType>> getBiometricTypes() async {
    try {
      List<BiometricType> bios = await auth.getAvailableBiometrics();
      print(bios.length == 0 ? 'No Bios' : 'Bios');
      setState(() {
        biometrics = bios;
      });
      isAndroid();
      return bios;
    } on Exception catch (err) {
      print("Error: " + err.toString());
      return null;
    }
  }

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
  void initState() {
    super.initState();
    getBiometricTypes();
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
            backgroundColor: Color(THEME.PRIMARY_COLOR),
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.fingerprint,
                          size: 50,
                          color: Color(THEME.PRIMARY_COLOR),
                        ),
                        Image.asset("assets/images/biometricslock_icon.png",
                            color: Color(THEME.PRIMARY_COLOR), width: 90),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height / 5,
                    child: Text(
                      "Enable biometrics for easy logging in",
                      style: TextStyle(
                          fontSize: 17, color: Color(THEME.PRIMARY_COLOR)),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          'Enable ${biometric}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
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
                        inactiveThumbColor: Colors.blueGrey,
                        activeTrackColor: Colors.green,
                      ),
                    ],
                  ),
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
