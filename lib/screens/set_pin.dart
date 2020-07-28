import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:voyager/services/background.dart';

class SetPin extends StatefulWidget {
  SetPin({Key key}) : super(key: key);

  @override
  _SetPinState createState() => _SetPinState();
}

class _SetPinState extends State<SetPin> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController textController = new TextEditingController();
  final FocusNode textFocus = FocusNode();
  final _storage = FlutterSecureStorage();

  String pin;
  bool first = true;
  String confirmPin;
  checkPin() {
    if (pin == confirmPin) {
      return true;
    } else {
      return false;
    }
  }

  savePin() async {
    await _storage.write(key: 'pin', value: pin);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          BackgroundClass(),
          Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => {
                    Navigator.of(context).pop(),
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                centerTitle: true,
                title: first ? Text('Set Pin') : Text('Confirm Pin'),
                backgroundColor: Colors.transparent,
              ),
              backgroundColor: Colors.transparent,
              body: Column(children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Container(
                    width: 150,
                    child: TextField(
                      focusNode: textFocus,
                      controller: textController,
                      textAlign: TextAlign.center,
                      obscureText: true,
                      style: TextStyle(
                        letterSpacing: 2.0,
                      ),
                      decoration: new InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => textController.clear(),
                          icon: Icon(Icons.clear),
                        ),
                        counter: SizedBox.shrink(),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: false,
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      onSubmitted: (term) {
                        if (!first) {
                          textFocus.unfocus();
                        }
                      },
                      onChanged: (value) => {
                        if (first)
                          {
                            pin = value,
                          }
                        else
                          {
                            confirmPin = value,
                          }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.blue[600])),
                  onPressed: () async {
                    textFocus.unfocus();
                    textController.clear();
                    if (first) {
                      if (pin.length < 4) {
                        showAlertDialog(
                            context, 'Mininum Length is 4', 'Error!!');
                      } else {
                        setState(() {
                          first = false;
                        });
                      }
                    } else {
                      if (checkPin()) {
                        showAlertDialog(
                            context, 'Successfully added', 'Success');
                        await savePin();

                        // Navigator.of(context).pop();
                      } else {
                        showAlertDialog(
                            context, 'Pins do not match', 'Error!!');
                        setState(() {
                          first = true;
                        });
                      }
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white70),
                  ),
                  color: Colors.transparent,
                )
              ]))
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, String msg, String title) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        if (msg == 'Successfully added')
          Navigator.of(context).popUntil(ModalRoute.withName('/loginoptions'));
        else {
          Navigator.of(context).pop();
        }
      },
    );
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              content: Text(msg),
              actions: [
                okButton,
              ],
            ));
  }

//   _displaySnackBar(BuildContext context, String msg) {
//     final snackBar = SnackBar(
//       content: Text(
//         msg,
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         textAlign: TextAlign.center,
//       ),
//       backgroundColor: Colors.red,
//     );
//     _scaffoldKey.currentState.showSnackBar(snackBar);
//   }
}
