import 'package:flutter/material.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/modules/more_about_voyager/pages/about_url.dart' as URL;
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;
import 'package:webview_flutter/webview_flutter.dart';

class MoreAboutVoyagerPage extends StatefulWidget {
  @override
  _MoreAboutVoyagerPageState createState() => _MoreAboutVoyagerPageState();
}

class _MoreAboutVoyagerPageState extends State<MoreAboutVoyagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('More About Voyager'),
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
      body: Stack(children: [
        BackgroundClass(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Cards(i: 0),
                Cards(i: 1),
                Cards(i: 2),
                Cards(i: 3),
                Cards(i: 4),
                Cards(i: 5),
                Cards(i: 6),
                Cards(i: 7),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class Cards extends StatefulWidget {
  int i;
  Cards({Key key, this.i}) : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  List title = [
    "Programme Overview",
    "Membership",
    "Earn Miles",
    "Spend Miles",
    "Status and Benefits",
    "Claim Miles",
    "Voyage Partners",
    "Legal"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          child: Text(
            title[widget.i],
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () => {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    DisplayDescription(i: widget.i))),
          },
        ),
      ),
    );
  }
}

class DisplayDescription extends StatefulWidget {
  final i;

  DisplayDescription({Key key, this.i}) : super(key: key);

  @override
  _DisplayDescriptionState createState() => _DisplayDescriptionState();
}

class _DisplayDescriptionState extends State<DisplayDescription> {
  List title = [
    "Programme Overview",
    "Membership",
    "Earn Miles",
    "Spend Miles",
    "Status and Benefits",
    "Claim Miles",
    "Voyage Partners",
    "Legal"
  ];

  List descrip = [
    "SAA Voyager is South African Airways’ Loyalty programme. It serves to reward our frequent flyers equitably through the accrual and redemption of Miles. These Miles can be redeemed for flights, upgrades and other rewards.",
    "Membership in SAA Voyager is free of charge and anyone from two years and older may enrol. ",
    "The SAA Voyager currency is Miles. You earn Miles with every qualifying transaction with our partners. It is important to note the different types of Miles you can earn. ",
    "Spend SAA Voyager Miles on Global flights or Non-airline awards. SAA Voyager members can spend Miles on 26 Star Alliance Partner Airlines or on 10 other Airline partners. Other Airline partners include  Airlink, Swaziland Airlink, SA Express, Mango, Emirates, Jet Airways, Virgin Atlantic and Virgin Australia. Spending options for non-airline awards include, car rental, accommodation, spa vouchers, cruises, retail awards and more."
    /*Spend your SAA Voyager Miles on global flights or non-airline Awards. SAA Voyager Members can spend Miles on more than 35 airline partnerships, including the Star Alliance global network. Spending options for non-airline awards include car rental, spa vouchers, retail awards and more.*/,
    "As a valued SAA Voyager member, you are able to improve your Tier status, based on your support and enjoy more benefits. Your SAA Voyager elite status means access to additional benefits and privileges based on your Tier status. Tier Miles are earned per calendar year on SAA, Star Alliance, SA Express, Airlink and Swaziland Airlink.",
    "For your Miles to track systematically, simply quote your unique SAA Voyager membership number during the booking process or at point of sale. Missing Miles for Star Alliance airlines, SAA, SA Express and Airlink can be claimed by going to the home screen and tapping on claim miles. Missing Miles for all other partners can be claimed via the Voyager Service Centre. "
    /*Have you have flown without inserting your SAA Voyager number at the time of booking? If yes, then there is no need to worry. Missing Miles can be claimed by going to the home screen and tapping on ‘Claim Missing Miles’ then select the partner you wish to claim Miles for. */,
    "Enhance your travel experience with exclusive holiday and leisure awards offered by our prominent partners around the world, including airlines, five-star hotels and car rental companies. Enhance your holiday with exclusive holiday and leisure awards offered by our prominent partners around the world, including Nedbank – SAA Voyager Credit and Cheque Cards, airlines, five-star hotels and more.",
    "The Terms and Conditions form the basis of the SAA Voyager Programme and are binding and enforceable against every Member. These Terms and Conditions are intended to protect both Members and South African Airways. It is the Member\'s responsibility to read and understand these Terms and Conditions."
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text(title[widget.i]),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text("Log Out",
                            style:
                                TextStyle(color: Color(THEME.PRIMARY_COLOR))),
                        content: Text("Do you want to log out ?",
                            style:
                                TextStyle(color: Color(THEME.TERTIARY_COLOUR))),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text("Yes",
                                style: TextStyle(
                                    color: Color(THEME.PRIMARY_COLOR))),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()));
                            },
                          ),
                          new FlatButton(
                            child: new Text("No",
                                style: TextStyle(
                                    color: Color(THEME.PRIMARY_COLOR))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Image.asset(
                "assets/images/logout.png",
                color: Colors.white,
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
        body: Stack(children: [
          BackgroundClass(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(40, 30, 40, 10),
                child: Text(
                  descrip[widget.i],
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DisplaySite(i: widget.i)));
                },
                child: Text("Read More"),
              )
            ],
          )
        ]));
  }
}

class DisplaySite extends StatefulWidget {
  final i;
  DisplaySite({Key key, this.i}) : super(key: key);

  @override
  _DisplaySiteState createState() => _DisplaySiteState();
}

class _DisplaySiteState extends State<DisplaySite> {
  List urls = [
    URL.programme_overview,
    URL.membership,
    URL.earn_miles,
    URL.spend_miles,
    URL.status_benefits,
    URL.claim_miles,
    URL.voyager_partners,
    URL.legal,
    URL.legal,
    URL.legal
  ];

  List title = [
    "Programme Overview",
    "Membership",
    "Earn Miles",
    "Spend Miles",
    "Status and Benefits",
    "Claim Miles",
    "Voyage Partners",
    "Legal",
    "Terms of Use",
    "Privacy Policy"
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
