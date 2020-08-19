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
      align: IndicatorAlign.bottom,
      indicatorSpace: 10.0,
      padding: const EdgeInsets.all(50),
      indicatorColor: Colors.white,
      indicatorSelectorColor: Colors.black,
      shape: IndicatorShape.circle(size: 10),
      // shape: IndicatorShape.roundRectangleShape(size: Size.square(12),cornerSize: Size.square(3)),
      // shape: IndicatorShape.oval(size: Size(12, 8)),

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
    );
  }
}
