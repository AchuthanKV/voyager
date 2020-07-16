import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticateFingerPrint extends StatefulWidget {
  AuthenticateFingerPrint({Key key}) : super(key: key);

  @override
  _AuthenticateFingerPrintState createState() =>
      _AuthenticateFingerPrintState();
}

class _AuthenticateFingerPrintState extends State<AuthenticateFingerPrint> {
  LocalAuthentication auth = LocalAuthentication();

  String usingBio = "false";

  // Map data = {};
  // bool _canCheckBiometrics = false;
  // List<BiometricType> _availableBiometrics;
  // String _authorized = "Not Authorized";

  final _storage = FlutterSecureStorage();

  // Future<void> _checkBiometrics() async {
  //   bool canCheckBiometrics;
  //   try {
  //     canCheckBiometrics = await auth.canCheckBiometrics;
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _canCheckBiometrics = canCheckBiometrics;
  //   });
  //   _getAvailableBiometrics();
  // }

  // Future<void> _getAvailableBiometrics() async {
  //   List<BiometricType> availableBiometrics;
  //   try {
  //     availableBiometrics = await auth.getAvailableBiometrics();
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _availableBiometrics = availableBiometrics;
  //   });
  //   _authenticate();
  // }

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
    return Container(
      child: AlertDialog(
        content: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            RaisedButton(
              child: Text('Authenticate'),
              onPressed: () {
                _authenticate();
              },
            ),
            SizedBox(
              height: 30,
            ),
            // RaisedButton(
            //   child: Text('Back'),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
