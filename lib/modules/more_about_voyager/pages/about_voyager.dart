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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()));
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
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
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 300,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        "Programme Overview ",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProgramOverview())),
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 300,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        "Membership",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Membership()))
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 300,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        "Earn Miles ",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => EarnMiles()))
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 300,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        "Spend Miles ",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => SpendMiles()))
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 300,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        "Status and Benefits ",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                StatusBenefits()))
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 300,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        "Claim Miles ",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => ClaimMiles()))
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 300,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        "Voyager Partners ",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                VoyagerPartners()))
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 300,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        "Legal ",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Legal()))
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class ProgramOverview extends StatefulWidget {
  ProgramOverview({Key key}) : super(key: key);

  @override
  _ProgramOverviewState createState() => _ProgramOverviewState();
}

class _ProgramOverviewState extends State<ProgramOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Programme Overview'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
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
                  "SAA Voyager is South African Airways’ Loyalty programme. It serves to reward our frequent flyers equitably through the accrual and redemption of Miles. These Miles can be redeemed for flights, upgrades and other rewards.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              backgroundColor: Color(THEME.PRIMARY_COLOR),
                              title: Text("Programme Overview"),
                              centerTitle: true,
                            ),
                            body: WebView(
                              initialUrl: URL.programme_overview,
                            ),
                          )));
                },
                child: Text("Read More"),
              )
            ],
          )
        ]));
  }
}

class Membership extends StatefulWidget {
  Membership({Key key}) : super(key: key);

  @override
  _MembershipState createState() => _MembershipState();
}

class _MembershipState extends State<Membership> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Membership'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
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
                  "Membership in SAA Voyager is free of charge and anyone from two years and older may enrol. ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              backgroundColor: Color(THEME.PRIMARY_COLOR),
                              title: Text("Membership"),
                              centerTitle: true,
                            ),
                            body: WebView(
                              initialUrl: URL.membership,
                            ),
                          )));
                },
                child: Text("Read More"),
              )
            ],
          )
        ]));
  }
}

class EarnMiles extends StatefulWidget {
  EarnMiles({Key key}) : super(key: key);

  @override
  _EarnMilesState createState() => _EarnMilesState();
}

class _EarnMilesState extends State<EarnMiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Earn Miles'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
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
                  "The SAA Voyager currency is Miles. You earn Miles with every qualifying transaction with our partners. It is important to note the different types of Miles you can earn. ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              backgroundColor: Color(THEME.PRIMARY_COLOR),
                              title: Text("Earn Miles"),
                              centerTitle: true,
                            ),
                            body: WebView(
                              initialUrl: URL.earn_miles,
                            ),
                          )));
                },
                child: Text("Read More"),
              )
            ],
          )
        ]));
  }
}

class SpendMiles extends StatefulWidget {
  SpendMiles({Key key}) : super(key: key);

  @override
  _SpendMilesState createState() => _SpendMilesState();
}

class _SpendMilesState extends State<SpendMiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Spent Miles'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
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
                  "Spend SAA Voyager Miles on Global flights or Non-airline awards. SAA Voyager members can spend Miles on 26 Star Alliance Partner Airlines or on 10 other Airline partners. Other Airline partners include  Airlink, Swaziland Airlink, SA Express, Mango, Emirates, Jet Airways, Virgin Atlantic and Virgin Australia. Spending options for non-airline awards include, car rental, accommodation, spa vouchers, cruises, retail awards and more.",
                  /*Spend your SAA Voyager Miles on global flights or non-airline Awards. SAA Voyager Members can spend Miles on more than 35 airline partnerships, including the Star Alliance global network. Spending options for non-airline awards include car rental, spa vouchers, retail awards and more.*/ textAlign:
                      TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              backgroundColor: Color(THEME.PRIMARY_COLOR),
                              title: Text("Spend Miles"),
                              centerTitle: true,
                            ),
                            body: WebView(
                              initialUrl: URL.spend_miles,
                            ),
                          )));
                },
                child: Text("Read More"),
              )
            ],
          )
        ]));
  }
}

class StatusBenefits extends StatefulWidget {
  StatusBenefits({Key key}) : super(key: key);

  @override
  _StatusBenefitsState createState() => _StatusBenefitsState();
}

class _StatusBenefitsState extends State<StatusBenefits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Status and Benefits'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
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
                  "As a valued SAA Voyager member, you are able to improve your Tier status, based on your support and enjoy more benefits. Your SAA Voyager elite status means access to additional benefits and privileges based on your Tier status. Tier Miles are earned per calendar year on SAA, Star Alliance, SA Express, Airlink and Swaziland Airlink.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              backgroundColor: Color(THEME.PRIMARY_COLOR),
                              title: Text("Status and Benefits"),
                              centerTitle: true,
                            ),
                            body: WebView(
                              initialUrl: URL.status_benefits,
                            ),
                          )));
                },
                child: Text("Read More"),
              )
            ],
          )
        ]));
  }
}

class ClaimMiles extends StatefulWidget {
  ClaimMiles({Key key}) : super(key: key);

  @override
  _ClaimMilesState createState() => _ClaimMilesState();
}

class _ClaimMilesState extends State<ClaimMiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Claim Miles'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
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
                  "For your Miles to track systematically, simply quote your unique SAA Voyager membership number during the booking process or at point of sale. Missing Miles for Star Alliance airlines, SAA, SA Express and Airlink can be claimed by going to the home screen and tapping on claim miles. Missing Miles for all other partners can be claimed via the Voyager Service Centre. ",
                  /*Have you have flown without inserting your SAA Voyager number at the time of booking? If yes, then there is no need to worry. Missing Miles can be claimed by going to the home screen and tapping on ‘Claim Missing Miles’ then select the partner you wish to claim Miles for. */ textAlign:
                      TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              backgroundColor: Color(THEME.PRIMARY_COLOR),
                              title: Text("Claim Miles"),
                              centerTitle: true,
                            ),
                            body: WebView(
                              initialUrl: URL.claim_miles,
                            ),
                          )));
                },
                child: Text("Read More"),
              )
            ],
          )
        ]));
  }
}

class VoyagerPartners extends StatefulWidget {
  VoyagerPartners({Key key}) : super(key: key);

  @override
  _VoyagerPartnersState createState() => _VoyagerPartnersState();
}

class _VoyagerPartnersState extends State<VoyagerPartners> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Voyager Partners'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
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
                  "Enhance your travel experience with exclusive holiday and leisure awards offered by our prominent partners around the world, including airlines, five-star hotels and car rental companies. Enhance your holiday with exclusive holiday and leisure awards offered by our prominent partners around the world, including Nedbank – SAA Voyager Credit and Cheque Cards, airlines, five-star hotels and more.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              backgroundColor: Color(THEME.PRIMARY_COLOR),
                              title: Text("Voyager Partners"),
                              centerTitle: true,
                            ),
                            body: WebView(
                              initialUrl: URL.voyager_partners,
                            ),
                          )));
                },
                child: Text("Read More"),
              )
            ],
          )
        ]));
  }
}

class Legal extends StatefulWidget {
  Legal({Key key}) : super(key: key);

  @override
  _LegalState createState() => _LegalState();
}

class _LegalState extends State<Legal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(THEME.PRIMARY_COLOR),
          title: Text('Legal'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
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
                  "The Terms and Conditions form the basis of the SAA Voyager Programme and are binding and enforceable against every Member. These Terms and Conditions are intended to protect both Members and South African Airways. It is the Member\'s responsibility to read and understand these Terms and Conditions.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              backgroundColor: Color(THEME.PRIMARY_COLOR),
                              title: Text("Legal"),
                              centerTitle: true,
                            ),
                            body: WebView(
                              initialUrl: URL.legal,
                            ),
                          )));
                },
                child: Text("Read More"),
              )
            ],
          )
        ]));
  }
}
