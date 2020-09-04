import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:voyager/main.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/modules/login/widgets/login_error.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _pinEditingController =
      new TextEditingController();
  bool _isLoading = false;
  bool showSnackBar = false;
  int _pinLength = 6;
  String storedPin;
  String _pin;
  bool isAuthenticated = false;
  String membershipId;
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  LocalAuthentication auth = LocalAuthentication();
  final FocusNode _pinFocus = FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final PinDecoration _pinDecoration = BoxLooseDecoration(
    solidColor: Colors.white60,
    strokeColor: Colors.black,
    radius: Radius.circular(10),
    enteredColor: Colors.yellow[800],
  );

  userLogin() async {
    var response = await LoginUser().authenticateUser(membershipId, _pin);

    setState(() {
      _isLoading = false;
    });

    if (response == null) {
      _pin = "";
      _pinEditingController.clear();
      LoginErrorAlert.displaySnackBar(_scaffoldKey);
    } else if (response == 'false') {
      await LoginErrorAlert.showAlertDialog(_scaffoldKey.currentContext);
      _pinEditingController.clear();
      setState(() {
        _isLoading = false;
      });
    } else if (response == 'true') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (Route<dynamic> route) => false);
    }
  }

  Container backGround() {
    return Container(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: ClipRRect(
            // make sure we apply clip it properly
            child: Container(
          alignment: Alignment.center,
          color: Colors.grey.withOpacity(0.1),
        )),
      ),
    );
  }

  Container logoSection() {
    return Container(
      alignment: Alignment(0.0, 0.0),
      height: 130.0,
      //width: 100.0,
      margin: EdgeInsets.only(top: 50.0),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/newlogo.png'),
        fit: BoxFit.fitHeight,
      )),
    );
  }

  Container pinSection() {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.white54,
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        child: Row(
          children: <Widget>[
            Text(
              "PIN",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: PinInputTextField(
                focusNode: _pinFocus,
                pinLength: _pinLength,
                decoration: _pinDecoration,
                controller: _pinEditingController,
                textInputAction: TextInputAction.go,
                enabled: true,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.characters,
                onSubmit: (pin) {
                  _pin = pin;
                  if (pin.length == _pinLength) {
                    setState(() {
                      _isLoading = true;
                    });
                    userLogin();
                  } else {
                    _pinFocus.unfocus();
                  }
                },
                onChanged: (pin) {
                  _pin = pin;
                  if (pin.length == _pinLength) {
                    _pinFocus.unfocus();
                  }
                },
                enableInteractiveSelection: true,
              ),
            ),
          ],
        ));
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 55.0),
      child: RaisedButton(
        onPressed: () async {
          if (_pin == null) {
          } else if (_pin.length == _pinLength) {
            setState(() {
              _isLoading = true;
            });
            userLogin();
          }
        },
        elevation: 0.0,
        color: Color(THEME.BUTTON_COLOR),
        child: Text("Sign In", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Container forgotPasswordSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
      alignment: Alignment(1.0, 0.0),
      child: InkWell(
        child: Text(
          "Forgot Password?",
          style: TextStyle(
              color: Colors.black, decoration: TextDecoration.underline),
        ),
        onTap: () => Navigator.pushNamed(context, '/loginoptions'),
      ),
    );
  }

  Container otherAccountLogin() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
      alignment: Alignment(-1.0, 0.0),
      child: InkWell(
        child: Text(
          "Login to a different Account?",
          style: TextStyle(
              color: Colors.black, decoration: TextDecoration.underline),
        ),
        onTap: () => Navigator.push(
            context, new MaterialPageRoute(builder: (__) => LoginPage())),
      ),
    );
  }

  getStoredVal() async {
    var isBio = await (_storage.read(key: 'biometric'));

    var id = await _storage.read(key: 'membershipId');
    var pin = await _storage.read(key: 'pin');
    if (id != null && id != 'undefined') {
      if (mounted == true) {
        setState(() {
          membershipId = id;
          storedPin = pin;
          _pinLength = pin.length;
        });
      }
    }
    // print(isBio);
    if (isBio == 'true') {
      if (mounted == true) {
        setState(() {
          isAuthenticated = true;
        });
      }
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      }
    } on PlatformException catch (e) {
      auth.stopAuthentication();
      print("Exception $e");
    }
  }

  Container fingerPrint() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: new Icon(
            Icons.fingerprint,
            size: 70,
          ),
          onPressed: () {
            _authenticate();
          },
        ),
        SizedBox(
          width: 35,
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    getStoredVal();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: _isLoading
          ? Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage("assets/images/background.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: SpinKitHourGlass(
                  color: Colors.white,
                  size: 100.0,
                ),
              ),
            )
          : Scaffold(
              resizeToAvoidBottomPadding: false,
              body: GestureDetector(
                onTap: () {
                  _pinFocus.unfocus();
                },
                child: Stack(
                  children: <Widget>[
                    backGround(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        logoSection(),
                        forgotPasswordSection(),
                        pinSection(),
                        buttonSection(),
                        isAuthenticated
                            ? Column(
                                children: <Widget>[
                                  Text("OR"),
                                  fingerPrint(),
                                ],
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        otherAccountLogin(),
                      ],
                    )
                  ],
                ),
              )),
    );
  }
}
