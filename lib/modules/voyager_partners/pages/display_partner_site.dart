import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:voyager/modules/voyager_partners/pages/partner_url.dart' as URL;
import 'package:voyager/theme/theme.dart' as THEME;
import 'package:webview_flutter/webview_flutter.dart';

class DisplayPartnerSite extends StatefulWidget {
  final i;
  DisplayPartnerSite({Key key, this.i}) : super(key: key);

  @override
  _DisplayPartnerSiteState createState() => _DisplayPartnerSiteState();
}

class _DisplayPartnerSiteState extends State<DisplayPartnerSite> {
  List urls = [URL.europcar, URL.netflorist, URL.creditcard, URL.chequecard];

  List title = [
    "Europcar",
    "Netflorist",
    "Voyager Partners",
    "Voyager Partners"
  ];
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
          title: Text(title[widget.i]),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: progress,
          children: <Widget>[
            Container(
              child: WebView(
                initialUrl: urls[widget.i],
                onPageFinished: doneLoading,
                onPageStarted: startLoading,
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ));
  }
}
