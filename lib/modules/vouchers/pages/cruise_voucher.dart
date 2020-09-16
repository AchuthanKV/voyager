import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class CruiseVoucher extends StatefulWidget {
  @override
  _CruiseVoucherState createState() => _CruiseVoucherState();
}

class _CruiseVoucherState extends State<CruiseVoucher> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _selectionList = <String>[
    '',
    'Select Group1',
    'Select Group2',
    'Select Group3',
    'Select Group4'
  ];
  bool _isChecked = false;
  String _selectedValue = '';

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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Select Group',
                        ),
                        isEmpty: _selectedValue == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _selectedValue,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                    ),
                    keyboardType: TextInputType.text,
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
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
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
                          Navigator.pushNamed(context, '/termsandconditions');
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, bottom: 15.0),
                      child: InkWell(
                        child: Text(
                          "Make a Booking",
                          style: TextStyle(
                              color: Colors.indigo[900],
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/makeabooking');
                        },
                      ),
                    ),
                  ],
                )),
                new Container(
                    height: 45.0,
                    child: new RaisedButton(
                      textColor: Colors.white,
                      elevation: 0.0,
                      color: Color(THEME.BUTTON_COLOR),
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
}
