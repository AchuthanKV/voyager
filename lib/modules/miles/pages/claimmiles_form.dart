import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class ClaimMilesForm extends StatefulWidget {
  final i;
  ClaimMilesForm({Key key, this.i}) : super(key: key);
  @override
  _ClaimMilesFormState createState() => _ClaimMilesFormState();
}

class _ClaimMilesFormState extends State<ClaimMilesForm> {
  List partnerName = [
    "Aegean",
    "Air Canada",
    "Air China",
    "Air India",
    "Air New Zealand",
    "Airlink",
    "ANA",
    "Asiana Airlines",
    "Austrian",
    "Avianca",
    "Brussels Airlines",
    "Copa Airlines",
    "Croatia Airlines",
    "Egypt Air",
    "Ethiopian Airlines",
    "Eva Air",
    "GOL",
    "Lufthansa",
    "LOT Polish Airlines",
    "Scandinavian Airlines",
    "Shenzhen Airlines",
    "Singapore Airlines",
    "South African Airways",
    "Swiss",
    "TAP",
    "THAI",
    "Turkish Airlines",
    "United",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Claim Miles'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              //notifictn pg
            },
            child: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/plainbackground.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text(partnerName[widget.i],
                      style: TextStyle(fontSize: 18)),
                )),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text(
                'For your Miles to track systematically, simply quote your unique SAA Voyager membership number during the booking process or at point of sale. Missing miles for Star Alliance airlines, SAA, SA Express and Airlink can be claimed by going to Claim Miles page. Missing miles for all other partners can be claimed via the Voyager Service Center.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Please enter your ${partnerName[widget.i]} e-ticket number.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
