import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:voyager/services/background.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';

class BarcodeReader extends StatefulWidget {
  BarcodeReader({Key key}) : super(key: key);

  @override
  _BarcodeReaderState createState() => _BarcodeReaderState();
}

class _BarcodeReaderState extends State<BarcodeReader> {
  String result = "hello";
  Future scanQR() async {
    try {
      var qrResult = await BarcodeScanner.scan();
      if (qrResult != null)
        setState(() {
          result = qrResult.rawContent;
        });
      if (qrResult.type.toString() == 'Cancelled')
        setState(() {
          result = qrResult.type.toString();
        });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera Permission Denied";
        });
      } else {
        setState(() {
          result = "Unknown error. $ex";
        });
      }
    } on FormatException catch (e) {
      setState(() {
        result = "You pressed back button before scanning";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown error. $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      BackgroundClass(),
      Scaffold(
        appBar: AppBar(
          title: Text("Scan E-Ticket"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.camera),
                  color: Colors.white70,
                  onPressed: scanQR,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Scan E-Ticket',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                Text(result),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
