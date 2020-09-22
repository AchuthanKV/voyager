import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/modules/miles/pages/claimmiles_form.dart';
import 'package:voyager/modules/miles/pages/miles_infopage.dart';
import 'package:voyager/services/background.dart';

class ClaimMilesPage extends StatefulWidget {
  ClaimMilesPage({Key key}) : super(key: key);
  @override
  _ClaimMilesPageState createState() => _ClaimMilesPageState();
}

class _ClaimMilesPageState extends State<ClaimMilesPage> {
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _partnerName;
  List<dynamic> _partnerLogo;
  bool _isSearching;
  List searchresult = new List();
  List searchresultLogo = new List();
  bool isChanging = false;

  _ClaimMilesPageState() {
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

    _partnerLogo = [
      "agean.jpg",
      "aircanada.jpg",
      "airchina.jpg",
      "airindia.jpg",
      "airnewzealand.jpg",
      "airlink.jpg",
      "ana.jpg",
      "asiana.jpg",
      "austrian.jpg",
      "avianca.jpg",
      "brussels.jpg",
      "copa.jpg",
      "croaita.jpg",
      "egyptair.jpg",
      "ethiopian.jpg",
      "evaair.jpg",
      "gol_partner.png",
      "lufthanza.jpg",
      "polish.jpg",
      "scandinavian.jpg",
      "shenzen.jpg",
      "singapore.jpg",
      "saa.jpg",
      "swiss.jpg",
      "tap.jpg",
      "thai.jpg",
      "turkish.jpg",
      "united.jpg"
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => MilesInfoPage()));
        },
        tooltip: 'Increment',
        child: ImageIcon(
          AssetImage("assets/images/claimmiles.png"),
          size: 20,
        ),
        elevation: 2.0,
      ),
      key: globalKey,
      body: Stack(
        children: [
          BackgroundClass(),
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    "Miles can be claimed via the Voyager Service Centre.",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
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
                          size: 25,
                        ),
                        hintText: "Enter a partner for claim",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: new Container(
                    padding: EdgeInsets.only(top: 12),
                    child: new Column(
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
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                                Radius.circular(20))),
                                        child: FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ClaimMilesForm(
                                                              i: index)));
                                            },
                                            child: ListTile(
                                              title:
                                                  new Text(listData.toString()),
                                              leading: IconButton(
                                                  icon: Image.asset(
                                                    "assets/images/" + listLogo,
                                                  ),
                                                  onPressed: () {}),
                                              trailing: Icon(
                                                Icons.keyboard_arrow_right,
                                                size: 35,
                                                color: Colors.black,
                                              ),
                                            )),
                                      );
                                    },
                                  )
                                : new ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _partnerName.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String listData = _partnerName[index];
                                      return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  offset: Offset(0.0, 4.0),
                                                  blurRadius: 3.0,
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ClaimMilesForm(
                                                              i: index)));
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
          ),
        ],
      ),
    );
  }
}
