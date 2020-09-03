import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:voyager/modules/home/services/get_qrcode_string.dart';

class BarcodeGen extends StatefulWidget {
  BarcodeGen({Key key}) : super(key: key);

  @override
  _BarcodeGenState createState() => _BarcodeGenState();
}

class _BarcodeGenState extends State<BarcodeGen> {
  String codeData;
  getBarCodeDate() {
    codeData = QrcodeString().getBarCodeString();
    print(codeData);
  }

  @override
  Widget build(BuildContext context) {
    getBarCodeDate();
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
        color: Colors.white,
        child: Center(
          child: QrImage(
            data: codeData,
            version: QrVersions.auto,
            gapless: false,
            size: MediaQuery.of(context).size.width / 2,
          ),
        ));
  }
}
