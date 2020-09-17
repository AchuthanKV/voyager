import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class FlightVoucher extends StatefulWidget {
  @override
  _FlightVoucherState createState() => _FlightVoucherState();
}

class _FlightVoucherState extends State<FlightVoucher> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _selectionList = <String>[
    '',
    'Value1',
    'Value2',
    'Value3',
    'Value4'
  ];
  String _selectedValue = '';
  String radioValue = 'One Way';
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Create Voucher'),
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
        child: new Form(
            key: _formKey,
            autovalidate: true,
            child: new ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                formFieldSection('SAA, SA Express & Airlink Award'),
                formFieldSection('Select Award Name'),
                formFieldSection('Select Award Type'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: radioValue,
                      groupValue: radioValue,
                      onChanged: (String val) {
                        print(val);
                        setState(() {
                          radioValue = null;
                        });
                      },
                    ),
                    Text('One Way'),
                  ],
                ),
                formFieldSection('Select Region Of Travel'),
                formFieldSection('Select Cabin Class'),
                formFieldSection('Select Reward Name'),
                new TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Nominated Traveller',
                    labelText: 'Nominated Traveller',
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        //toggleCheckbox(value);
                        setState(() {
                          print(value);
                          isChecked = value;
                        });
                      },
                      activeColor: Color(THEME.PRIMARY_COLOR),
                      checkColor: Colors.white,
                      tristate: false,
                    ),
                  ),
                  Text('The information provided above is correct')
                ]),
                SizedBox(
                  height: 5,
                ),
                Container(
                  //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  padding: EdgeInsets.only(left: 0, right: 1),
                  //alignment: Alignment(2.0, 10.0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      inkWellSection(
                          "Term and Condition", '/termsandconditions'),
                      inkWellSection("Make a Booking", '/makeabooking'),
                      //makeaBookingSection()
                      //Text('Term and Condition')
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                new Container(
                    //padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                    //width: MediaQuery.of(context).size.width,
                    height: 45.0,
                    //padding: EdgeInsets.only(left: 20, right: 15, top: 20),
                    child: new RaisedButton(
                      textColor: Colors.white,
                      elevation: 0.0,
                      color: Color(THEME.BUTTON_COLOR),
                      //child: Text("SIGN IN", style: TextStyle(color: Colors.black)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: const Text('SUBMIT',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {},
                    )),
              ],
            )),
      ),
    );
  }

  InkWell inkWellSection(String title, String path) {
    return InkWell(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 15,
            color: Colors.indigo[900],
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline),
      ),
      onTap: () => Navigator.pushNamed(context, path),
    );
  }

  FormField formFieldSection(String selectTextValue) {
    return FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            //icon: const Icon(Icons.color_lens),
            labelText: selectTextValue,
          ),
          isEmpty: _selectedValue == '',
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              value: _selectedValue,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  //newContact.favoriteColor = newValue;
                  _selectedValue = newValue;
                  state.didChange(newValue);
                });
              },
              items: _selectionList.map((String value) {
                return new DropdownMenuItem(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
