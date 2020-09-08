import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:voyager/modules/hotdeals/pages/hotdeal_url.dart' as HotDealURL;

class HotDealsPage extends StatefulWidget {
  @override
  _HotDealsPageState createState() => _HotDealsPageState();
}

class _HotDealsPageState extends State<HotDealsPage> {
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
    return IndexedStack(
      index: progress,
      children: <Widget>[
        Container(
          child: WebView(
            initialUrl: HotDealURL.hotDealsURL,
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
    );
  }
}
