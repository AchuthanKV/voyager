import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:voyager/modules/home/pages/landing_home_page.dart';
import 'package:voyager/modules/home/pages/membership_card.dart';
import 'package:voyager/screens/barcode_scan.dart';
import 'package:voyager/screens/login_options.dart';
import 'package:page_indicator/page_indicator.dart';

class PageViewSwipe extends StatefulWidget {
  @override
  _PageViewSwipeState createState() => _PageViewSwipeState();
}

class _PageViewSwipeState extends State<PageViewSwipe> {
  PageController _controller = PageController(
    initialPage: 0,
  );
  int pageChange = 0;

  @override
  @mustCallSuper
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageIndicatorContainer(
      length: 2,
      child: PageView(
        onPageChanged: (index) {
          if (this.mounted) {
            setState(() {
              pageChange = index;
            });
          }
        },
        controller: _controller,
        children: [
          LandingPage(),
          MembershipCardPage(),
        ],
      ),
      align: IndicatorAlign.bottom,
      indicatorSelectorColor: Colors.white,
      indicatorColor: Colors.indigo[900],
      shape: IndicatorShape.circle(size: 8),
    );
  }
}
