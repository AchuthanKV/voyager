import 'package:flutter/material.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/modules/more_about_voyager/pages/about_voyager.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;
import 'package:flutter/services.dart';

class AirPartners extends StatefulWidget {
  AirPartners({Key key}) : super(key: key);

  @override
  _AirPartnersState createState() => _AirPartnersState();
}

class _AirPartnersState extends State<AirPartners> {
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _partnerName;
  List<dynamic> _partnerLogo;
  bool _isSearching;
  List searchresult = new List();
  List searchresultLogo = new List();
  bool isChanging = false;

  _AirPartnersState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    values();
  }

  void values() {
    _partnerName = List();
    _partnerLogo = List();

    _partnerName = [
      "Aegean",
      "Air Canada",
      "Air China",
      "Air India",
      "Air New Zealand",
      "Airlink",
      "ANA",
      "Asiana Airlines",
      "Austrian",
      //"Avianca Brazil",
      "Avianca",
      "Brussels Airlines",
      "Copa Airlines",
      "Croatia Airlines",
      "Egypt Air",
      //"El Al Israel Airlines",
      //"Emirates Skywards",
      //"Etihad Airways",
      "Ethiopian Airlines",
      "Eva Air",
      "GOL",
      // "Jet Airways",
      //"Jet Blue",
      "Lufthansa",
      //"Mango Airlines",
      "LOT Polish Airlines",
      //"SA Express",
      "Scandinavian Airlines",
      "Shenzhen Airlines",
      "Singapore Airlines",
      "South African Airways",
      //"Swaziland Airline",
      "Swiss",
      //"TAM Airlines",
      "TAP",
      "THAI",
      "Turkish Airlines",
      "United",
      //"Virgin Atlantic",
      //"Virgin Australia"
    ];

    _partnerLogo = [
      "agean.jpg",
      "aircanada.jpg",
      "airchina.jpg",
      "airindia.jpg",
      "airnewzealand.jpg",
      "airlink.jpg",
      //"swaziland.jpg",
      "ana.jpg",
      "asiana.jpg",
      "austrian.jpg",
      "avianca.jpg",
      "brussels.jpg",
      "copa.jpg",
      "croaita.jpg",
      "egyptair.jpg",
      //"claim_israel.jpg",
      //"emirates.jpg","etihad.jpg",
      "ethiopian.jpg",
      "evaair.jpg",
      "gol_partner.png",
      //"jetair.jpg","jetblue.jpg",
      "lufthanza.jpg",
      //"mango.jpg",
      "polish.jpg",
      //"saexpress.jpg",
      "scandinavian.jpg",
      "shenzen.jpg",
      "singapore.jpg",
      "saa.jpg",
      //"swaziland.jpg",
      "swiss.jpg",
      //"tam.jpg",
      "tap.jpg", "thai.jpg",
      "turkish.jpg", "united.jpg"
      //"virginatlantic.jpg","virgin.jpg"
    ];
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    searchresultLogo.clear();

    if (_isSearching != null) {
      for (int i = 0; i < _partnerName.length; i++) {
        String data = _partnerName[i];
        String logo = _partnerLogo[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
          searchresultLogo.add(logo);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Voyager Partners'),
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
      body: Stack(
        children: [
          BackgroundClass(),
          Container(
            child: Column(
              children: [
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Air Rewards",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(THEME.PRIMARY_COLOR)),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  child: Text(
                    "Miles can be claimed via the voyager Service Centre",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 28,
                        color: Colors.black),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 8,
                      top: 5,
                      bottom: 5),
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 10,
                      vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: searchOperation,
                      onTap: () {
                        setState(() {
                          isChanging = true;
                        });
                      },
                      onEditingComplete: () {
                        if (isChanging)
                          _handleSearchStart();
                        else {
                          _handleSearchEnd();
                        }
                      },
                      controller: _controller,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 30,
                        ),
                        hintText: "Search  for a Partner",
                        border: InputBorder.none,

                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                        //Color(THEME.PRIMARY_COLOR)
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: new Container(
                    padding: EdgeInsets.only(top: 40),
                    child: new Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Flexible(
                            child: searchresult.length != 0 ||
                                    _controller.text.isNotEmpty
                                ? new ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchresult.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String listData = searchresult[index];
                                      String listLogo = searchresultLogo[index];
                                      print(listData);
                                      print(listLogo);
                                      return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  offset:
                                                      Offset(0.0, 4.0), //(x,y)
                                                  blurRadius: 3.0,
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25))),
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          DisplaySite(i: 5)));
                                            },
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(.0),
                                                child: new ListTile(
                                                  title: new Text(
                                                      listData.toString()),
                                                  leading: IconButton(
                                                      icon: Image.asset(
                                                        "assets/images/" +
                                                            listLogo,
                                                      ),
                                                      onPressed: () {}),
                                                  trailing: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 35,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ));
                                    },
                                  )
                                : new ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _partnerName.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      print(_partnerLogo[index]);
                                      String listData = _partnerName[index];
                                      return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  offset:
                                                      Offset(0.0, 4.0), //(x,y)
                                                  blurRadius: 3.0,
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25))),
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          DisplaySite(i: 5)));
                                            },
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(.0),
                                                child: new ListTile(
                                                  title: new Text(
                                                      listData.toString()),
                                                  leading: IconButton(
                                                      icon: Image.asset(
                                                        "assets/images/" +
                                                            _partnerLogo[index],
                                                      ),
                                                      onPressed: () {}),
                                                  trailing: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 35,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ));
                                    },
                                  ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
