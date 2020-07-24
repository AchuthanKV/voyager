import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:voyager/screens/invite_page.dart';

class DrawerClass extends StatelessWidget {
  const DrawerClass({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/saa1.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ClipRRect(
          // make sure we apply clip it properly
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.1),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'User',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: 280,
                      height: 40,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(blurRadius: 10, color: Colors.transparent)
                          ],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: RaisedButton(
                        color: Colors.transparent,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/loginoptions');
                        },
                        child: Text(
                          'Login Options',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 280,
                      height: 40,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(blurRadius: 10, color: Colors.transparent)
                          ],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: RaisedButton(
                        color: Colors.transparent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InvitePage()));
                        },
                        child: Text(
                          'Invite Others',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
