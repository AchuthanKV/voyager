import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:contacts_service/contacts_service.dart';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voyager/theme/theme.dart' as THEME;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class InvitePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InvitePageState();
  }
}

class _InvitePageState extends State<InvitePage> {
  final _invitePageState = GlobalKey<ScaffoldState>();
  List<Contact> contacts = [];
  List<Contact> listOfContactsFilttered = [];
  List<int> listOfSelectedItem = [];
  //TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController nameEditingController = new TextEditingController();
  String _name;
  String _phone;
  bool isSearching;
  bool isSelected;
  int imageIndex;
  Uint8List imagedata;
  Map<int, Uint8List> selectedImageData;
  Color selectedContactColor;
  Map<int, Color> mapContactClolorList;

  @override
  void initState() {
    super.initState();
    isSelected = false;
    getAllContacts();
    setSelectedState();
    nameEditingController.addListener(() {
      filterContacts();
    });
    selectedImageData = new HashMap<int, Uint8List>();
    mapContactClolorList = new HashMap<int, Color>();
    selectedContactColor = Colors.transparent;
  }

  setSelectedState() async {
    imagedata = (await rootBundle.load('assets/images/circle_check.png'))
        .buffer
        .asUint8List();
  }

  filterContacts() {
    List<Contact> _contact = [];
    _contact.addAll(contacts);
    if (nameEditingController.text.isNotEmpty) {
      _contact.retainWhere((contact) {
        String searchTearm = nameEditingController.text.toLowerCase();
        String contactName = contact.displayName.toLowerCase();
        return contactName.contains(searchTearm);
      });
      setState(() {
        listOfContactsFilttered = _contact;
      });
    }
  }

  getAllContacts() async {
    if (await Permission.contacts.request().isGranted) {
      List<Contact> _contacts = (await ContactsService.getContacts()).toList();
      setState(() {
        contacts = _contacts;
      });
      print('show contact list ');
    }
  }

  _sendSMS() async {
    if (contacts.elementAt(imageIndex) != null)
      print('image index $imageIndex');
    print('name $_name');
    print('phone $_phone');
    String number = contacts.elementAt(imageIndex).phones.elementAt(0).value;
    number = '9131062031';
    print('phone number $number');
    String name = contacts.elementAt(imageIndex).displayName;
    var response = await http.post(/*"https://www.fast2sms.com/dev/bulk"*/"https://voyagermobile.flysaa.com/saamobile/SendSMS",
        headers: {
         /* "authorization":
              "TYE9wNnL6v3gVczSsRoHFrU4f10d2b5JCXhIpeK8uax7OPkAZjrqLuaY2sQHE7kynZjRwF8x5mPfTWoB",*/
          "Content-Type": "application/x-www-form-urlencoded",
        },
        //.header("Content-Type", "application/x-www-form-urlencoded")
        body:
            (/*"sender_id=FSTSMS&message=This%20is%20a%20test%20message%20$name&language=english&route=p&*/"{"+"numbers"+":"+"[$number]"+"}"));
    print('without status $response');
    var jsonResponse = json.decode(response.body);
    print(jsonResponse['detail']);
    print(response.body.toString());
    if (response.statusCode == 200) {
      print('in status');
      print(response.body.toString());
      showWarningMessage(jsonResponse['detail'].toString());
    } else {
      showWarningMessage(jsonResponse['detail']);
    }
  }

  showWarningMessage(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(
            message.contains('successfully') ? 'Success..' : 'Warning!!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(
                  '$message',
                  style: TextStyle(
                      color: message.contains('successfully')
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.red),
              ),
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //bool isSearching = phoneEditingController.text.isNotEmpty;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _invitePageState,
          appBar: AppBar(
            backgroundColor: Color(THEME.PRIMARY_COLOR),
            title: Center(
              child: Text(
                'INVITE OTHERS',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  iconMargin: EdgeInsets.symmetric(horizontal: 100),
                  icon: Icon(Icons.sms),
                  child: Text(
                    'SMS',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                Tab(
                  icon: Icon(Icons.email),
                  child: Text(
                    'EMAIL',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(children: listOfWidgets() //listofWidets,
              ),
        ),
      ),
    );
  }

  List<Widget> listOfWidgets() {
    List<Widget> widgetList = [
      Container(
          child: Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/images/saa2.jpg"),
                fit: BoxFit.fill,
                //gradient: LinearGradient(colors: [
                //  Color(THEME.BG_GRADIENT_COLOR_1),
                //  Color(THEME.BG_GRADIENT_COLOR_2)
                //], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: nameEditingController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Name',
                      suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (text) {
                    setState(() {
                      isSearching = nameEditingController.text.isNotEmpty;
                      _name = text;
                      print('name field$_name');
                    });
                  },
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.contacts),
                    hintText: 'Number',
                  ),
                  //controller: phoneEditingController,
                  onChanged: (text) {
                    setState(() {
                      _phone = text;
                          //phoneEditingController.text;
                      print('phone text $_phone');
                    });
                  },
                ),

                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: isSearching == true
                        ? listOfContactsFilttered.length
                        : contacts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Contact contact = isSearching == true
                          ? listOfContactsFilttered[index]
                          : contacts[index];
                      return Card(
                          //color: (isSelected && mapContactClolorList.containsKey(index))?selectedContactColor:Colors.white,
                          child: ListTile(
                              //selected: ,
                              //focusColor: isSelected? Colors.green: Colors.white,
                              onTap: () {
                                setState(() {
                                  //isSelected = true;
                                  imageIndex = index;
                                  if (listOfSelectedItem.contains(index)) {
                                    listOfSelectedItem.remove(index);
                                    contact.avatar =
                                        selectedImageData.remove(index);
                                    selectedContactColor =
                                        mapContactClolorList.remove(index);
                                    isSelected = false;
                                  } else {
                                    isSelected = true;
                                    listOfSelectedItem.add(index);
                                    selectedImageData.putIfAbsent(
                                        index, () => contact.avatar);
                                    mapContactClolorList.putIfAbsent(
                                        index, () => selectedContactColor);
                                    selectedContactColor = Colors.amber;
                                    contact.avatar = imagedata;
                                  }
                                  //listOfSelectedItem.add(index);
                                  print(index);
                                });
                              },
                              title: Text(
                                contact.displayName,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                (contact.phones.length > 0 &&
                                        contact.phones.elementAt(0) != null)
                                    ? contact.phones.elementAt(0).value
                                    : '',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              leading: (contact.avatar != null &&
                                      contact.avatar.length > 0)
                                  ? CircleAvatar(
                                      backgroundImage:
                                          MemoryImage(contact.avatar),
                                    )
                                  : CircleAvatar(
                                      child: Text(contact.initials())))); //),
                      // );
                    },
                  ),
                ),
                RaisedButton(
                  color: Colors.white10,
                  disabledColor: Colors.white10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.red)),
                  child: Text(
                    'Send Invite',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _fieldValidation();
                  },
                ) //),
              ],
            )),
      )),
      Container(
        padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        /*height: double.infinity,
        width: double.infinity,*/
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/saa2.jpg"),
            fit: BoxFit.fill,
            //gradient: LinearGradient(colors: [
            //  Color(THEME.BG_GRADIENT_COLOR_1),
            //  Color(THEME.BG_GRADIENT_COLOR_2)
            //], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Name',
              focusColor: Colors.green,
              hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Email Id',
                focusColor: Colors.green,
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),
          buildButtonContainer(),
        ]),
      )
      //emailContainer(),
    ];
    return widgetList;
  }

  _fieldValidation() {
    if (listOfSelectedItem.length > 0) {
      //service call method
      print('Service Call');
      _sendSMS();
      print(listOfSelectedItem.length);
    } else if ((_name == null || _name.isEmpty) &&
        (_phone == null || _phone.isEmpty)) {
      showWarningMessage('Please enter contact number and name!!');
    } else if (_name == null || _name.isEmpty) {
      showWarningMessage('Please enter contact name!');
    } else if (_phone == null || _phone.isEmpty) {
      print('phone field is empty');
      showWarningMessage('Please enter contact number!');
    }
  }
  Container buildButtonContainer() {
    return Container(
      height: 56.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23.0),
        gradient: LinearGradient(
          colors: [
            Color(0xFFFB415B),
            Color(0xFFEE5653),
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Center(
        child: Text(
          "SUBMIT",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),

      ),
    );
  }
}
