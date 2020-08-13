import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundClass extends StatelessWidget {
  const BackgroundClass({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/plainbackground.png"),
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
}
