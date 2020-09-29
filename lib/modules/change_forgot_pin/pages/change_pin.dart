import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:voyager/modules/change_forgot_pin/services/changepin_api.dart';
import 'package:voyager/modules/change_forgot_pin/services/changepin_status.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class ChangePin extends StatefulWidget {
  ChangePin({Key key}) : super(key: key);

  @override
  _ChangePinState createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  String oldPin;
  String newPin;
  String confirmPin;

  final _changePinKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  final TextEditingController oldPinController = new TextEditingController();
  final TextEditingController newPinController = new TextEditingController();
  final TextEditingController confirmPinController =
      new TextEditingController();
  final FocusNode _newpinFocus = FocusNode();
  final FocusNode _confirmpinFocus = FocusNode();

  Container textSection() {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 40),
        child: Form(
          key: _changePinKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter old Pin';
                  }
                  return null;
                },
                onChanged: (value) => {
                  oldPin = value,
                },
                controller: oldPinController,
                onFieldSubmitted: (term) {
                  oldPin = term;
                  FocusScope.of(context).requestFocus(_newpinFocus);
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Old Pin",
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => {newPin = value},
                onFieldSubmitted: (term) {
                  newPin = term;
                  FocusScope.of(context).requestFocus(_confirmpinFocus);
                },
                focusNode: _newpinFocus,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter new pin';
                  } else if (newPin.length < 4) {
                    return 'Minimum length is 4';
                  } else if (newPin != confirmPin) {
                    return 'Pins do not Match';
                  }
                  return null;
                },
                controller: newPinController,
                cursorColor: Colors.white,
                obscureText: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "New Pin",
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                onChanged: (value) => {
                  confirmPin = value,
                },
                keyboardType: TextInputType.number,
                onFieldSubmitted: (term) {
                  confirmPin = term;
                  _confirmpinFocus.unfocus();
                },
                focusNode: _confirmpinFocus,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please re-enter new pin';
                  } else if (newPin.length < 4) {
                    return 'Minimum length is 4';
                  } else if (newPin != confirmPin) {
                    return 'Pins do not Match';
                  }
                  return null;
                },
                controller: confirmPinController,
                cursorColor: Colors.white,
                obscureText: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Re-enter Pin",
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ));
  }

  Container logoSection() {
    return Container(
      alignment: Alignment(0.0, 0.0),
      height: 75.0,
      //width: 100.0,
      margin: EdgeInsets.only(top: 40.0),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/logo.png'),
        fit: BoxFit.fitHeight,
      )),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45.0,
      padding: EdgeInsets.only(left: 20, right: 15),
      child: RaisedButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();

          if (_changePinKey.currentState.validate()) {
            setState(() {
              _isLoading = true;
            });

            //change pin api
            bool status = await ChangepinApi().changePin(oldPin, newPin);
            setState(() {
              _isLoading = false;
            });
            if (status) {
              ChangepinStatus.displaySnackBar(_scaffoldKey,
                  "Successfully Changed Pin. Please login again!");
              await new Future.delayed(const Duration(seconds: 3));
              Navigator.push(
                  context, new MaterialPageRoute(builder: (__) => LoginPage()));
            } else {
              newPinController.clear();
              confirmPinController.clear();
              oldPinController.clear();
              ChangepinStatus.displaySnackBar(
                  _scaffoldKey, ChangepinStatus.errorMsg);
            }
          }
        },
        textColor: Colors.white,
        elevation: 0.0,
        color: Color(THEME.BUTTON_COLOR),
        child: Text("SUBMIT", style: TextStyle(color: Colors.black)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundClass(),
        Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Change Pin"),
            centerTitle: true,
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
            child: _isLoading
                ? Center(
                    child: SpinKitHourGlass(
                      color: Colors.white,
                      size: 100.0,
                    ),
                  )
                : ListView(
                    children: <Widget>[
                      logoSection(),
                      SizedBox(
                        height: 50,
                      ),
                      textSection(),
                      buttonSection(),
                    ],
                  ),
          ),
        )
      ],
    );
  }
}
