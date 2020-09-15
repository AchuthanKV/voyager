import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/modules/home/pages/membership_card.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class DonateMilesPage extends StatefulWidget {
  @override
  _DonateMilesPageState createState() => _DonateMilesPageState();
}

class _DonateMilesPageState extends State<DonateMilesPage> {
  String donateMilesString =
      "Extend a hand of hope to children living with life threatening illnesses and help them realise their dreams by donating some of your Miles to the Reach For A Dream foundation and/or make a valuable contribution to our collective efforts towards saving the planet and preserving our natural resources and wildlife through donating to the World Wildlife Fund South Africa.\n\nBy donating Miles to Wings and Wishes, it affords a child the opportunity to receive urgent medical attention.\n\nTaungana is a movement that empowers rural African high school girls with the opportunity to access and explore science, technology, engineering, entrepreneurship and math (STEM).\n\nThe Nelson Mandela's Children fund changes the way in which society treats children and youth by improving their conditions and lives.";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          Text(
            donateMilesString,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '\n*Note: Minimum miles to donate is 3000.',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 25),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 10.0, bottom: 20),
            child: RaisedButton(
              child: Text(
                'Next',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MembershipCardPage()));
              },
              textColor: Colors.white,
              elevation: 0.0,
              color: Color(THEME.PRIMARY_COLOR),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          )
        ]),
      ),
    );
  }
}
