import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/screens/login_page.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class DineVoucher extends StatefulWidget {
  @override
  _DineVoucherState createState() => _DineVoucherState();
}

class _DineVoucherState extends State<DineVoucher> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  List _selectionList = ['Select1', 'Select2', 'Select3', 'Select4'];
  List _selectGroupList = [
    'Select Group1',
    'Select Group2',
    'Select Group3',
    'Select Group4'
  ];

  bool isChecked = false;
  bool _isChecked = false;

  _saveForm() {
    var form = _formKey.currentState;
    Map data = {
      'selectionList': _selectionList,
      'selectGroupList': _selectGroupList,
    };
    print(data);
    if (form.validate()) {
      form.save();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Create Voucher'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
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
        child: new Form(
          key: _formKey,
          child: new ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.grey[200],
                  ),
                  child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Select';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _selectionList = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Select",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    items: _selectionList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectionList = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.grey[200],
                  ),
                  child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Select Group';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _selectGroupList = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Select Group",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    items: _selectGroupList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectGroupList = value;
                      });
                    },
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Transform.scale(
                  scale: 1,
                  child: Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value;
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: Colors.indigo[900],
                    tristate: false,
                  ),
                ),
                Text('The information provided above is correct')
              ]),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: InkWell(
                    child: Text(
                      "Terms and Conditions",
                      style: TextStyle(
                          color: Colors.indigo[900],
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      print("value of your terms");
                    },
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                margin: EdgeInsets.only(top: 10.0, bottom: 30),
                child: RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  onPressed: _saveForm,
                  textColor: Colors.white,
                  elevation: 0.0,
                  color: Color(THEME.PRIMARY_COLOR),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
