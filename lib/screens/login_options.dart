import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticateFingerprint extends StatefulWidget {
  AuthenticateFingerprint({Key key}) : super(key: key);

  @override
  _AuthenticateFingerprintState createState() =>
      _AuthenticateFingerprintState();
}

class _AuthenticateFingerprintState extends State<AuthenticateFingerprint> {
  LocalAuthentication auth = LocalAuthentication();
  final _storage = FlutterSecureStorage();
  String usingBio = "false";
  Map data = {};
  bool _canCheckBiometrics = false;
  List<BiometricType> _availableBiometrics;
  String _authorized = "Not Authorized";
  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Scan your Fingerprint to authenticate",
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print("Exception $e");
    }
    if (!mounted) return;
    setState(() {
      _authorized = authenticated ? "Authorized" : "Not Authorized";
    });
    if (_canCheckBiometrics) {
      _storage.write(key: 'biometric', value: 'true');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage("assets/images/saa2.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: ClipRRect(
              // make sure we apply clip it properly
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.grey.withOpacity(0.1),
                  ))),
        ),
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
                  Text('Can check Biometrics : $_canCheckBiometrics\n '),
                  RaisedButton(
                    child: Text('Check Biometrics'),
                    onPressed: () {
                      print("Hello: $usingBio");
                      _checkBiometrics();
                    },
                  ),
                  Text('Available Biometrics : $_availableBiometrics\n '),
                  RaisedButton(
                    child: Text('Get available Biometrics : '),
                    onPressed: () {
                      _getAvailableBiometrics();
                    },
                  ),
                  Text('Current State :  $_authorized\n '),
                  RaisedButton(
                    child: Text('Authenticate'),
                    onPressed: () {
                      _authenticate();
                      getStoredVal();
                    },
                  ),
                  RaisedButton(
                    child: Text('Back'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(usingBio),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  getStoredVal() async {
    usingBio = await (_storage.read(key: 'biometric'));

    setState(() {
      usingBio = usingBio;
    });
  }
}
