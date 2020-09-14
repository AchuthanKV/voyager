import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/theme/theme.dart' as THEME;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:voyager/modules/vouchers/pages/voucher_url.dart' as VoucherURL;

class VoucherMakeBooking extends StatefulWidget {
  @override
  _VoucherMakeBookingState createState() => _VoucherMakeBookingState();
}

class _VoucherMakeBookingState extends State<VoucherMakeBooking> {
  num progress = 1;

  doneLoading(String A) {
    setState(() {
      progress = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      progress = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Make a Booking'),
        ),
        body: IndexedStack(
          index: progress,
          children: <Widget>[
            Container(
              child: WebView(
                initialUrl: VoucherURL.makeBookingURL,
                onPageFinished: doneLoading,
                onPageStarted: startLoading,
              ),
            ),
            Container(
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(child: CircularProgressIndicator()),
                      Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Text('Loading...'))
                    ])),
          ],
        ));
  }
}
