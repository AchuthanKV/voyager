import 'package:flutter/material.dart';
import 'package:voyager/modules/my-profile/pages/my_profile.dart';

Dialog imageDialog = Dialog(
  child: Container(
    color: Colors.white,
    child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton(
              onPressed: () {},
              child: Text(
                'Take Picture',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text(
                'Select Picture form Gallery',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            )
          ],
        )),
  ),
);
