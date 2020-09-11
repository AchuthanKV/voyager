import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class Address extends StatefulWidget {
  Address({Key key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _signupFormKey = GlobalKey<FormState>();
  final _signupScaffold = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool isSignUp = false;
  bool signedUp = false;
  bool isEmailOn = false;
  bool isNotificationOn = false;

  final TextEditingController zipcodeController = new TextEditingController();
  final TextEditingController areaController = new TextEditingController();
  final TextEditingController nationalityController =
      new TextEditingController();
  final TextEditingController line1Controller = new TextEditingController();

  final TextEditingController line2Controller = new TextEditingController();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  final TextEditingController stateController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();

  String _addressLine1;
  String _addressLine2;
  String _city;
  String _state;
  String _zipcode;
  String _email;
  String _phone;
  String _areacode;
  String _isdcode;

  String _nationality;
  List _locations = ['+91', '72'];
  List _nations = ['India', 'USA', 'China'];
  List _genders = ['Male', 'Female'];
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _mailFocus = FocusNode();
  final FocusNode _line1Focus = FocusNode();
  final FocusNode _line2Focus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _zipFocus = FocusNode();

  Container buttonSection() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            margin: EdgeInsets.only(top: 30.0, bottom: 30),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_signupFormKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  _signupFormKey.currentState.save();
                  Map data = {
                    'areaCode': _areacode,
                    'phone': _phone,
                    'email': _email,
                    'addressLine1': _addressLine1,
                    'addressLine2': _addressLine2,
                    'city': _city,
                    'state': _state,
                    'zipcode': _zipcode,
                    'nation': _nationality,
                  };
                  print(data);
                  setState(() {
                    _isLoading = true;
                  });
                }
              },
              textColor: Colors.white,
              elevation: 0.0,
              color: Color(THEME.BUTTON_COLOR),
              child: Text(
                "SUBMIT",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MY PROFILE"),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              BackgroundClass(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey[300],
                      height: 50,
                      child: Center(
                          child: Text(
                        "ADDRESS",
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      child: Form(
                        key: _signupFormKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 30.0),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Colors.grey[300],
                                      ),
                                      child: DropdownButtonFormField(
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select an area';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _areacode = value;
                                          },
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            hintText: "Area Code",
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white70)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          items: _locations.map((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _areacode = value;
                                            });
                                          }),
                                    )),
                                Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                    onFieldSubmitted: (term) {
                                      FocusScope.of(context)
                                          .requestFocus(_mailFocus);
                                    },
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a Phone Number';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      _phone = value;
                                    },
                                    controller: phoneController,
                                    cursorColor: Colors.white70,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: "Phone",
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white70)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      //Color(THEME.PRIMARY_COLOR)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              focusNode: _mailFocus,
                              onFieldSubmitted: (term) {
                                FocusScope.of(context)
                                    .requestFocus(_line1Focus);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a Email';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                _email = value;
                              },
                              controller: emailController,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "Email Address",
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white70)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintStyle: TextStyle(color: Colors.grey),
                                //Color(THEME.PRIMARY_COLOR)
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              focusNode: _line1Focus,
                              onFieldSubmitted: (term) {
                                FocusScope.of(context)
                                    .requestFocus(_line2Focus);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter valid Address Line';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                _addressLine1 = value;
                              },
                              controller: line1Controller,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "Address Line 1",
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(THEME.PRIMARY_COLOR))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              focusNode: _line2Focus,
                              onFieldSubmitted: (term) {
                                FocusScope.of(context).requestFocus(_cityFocus);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Valid Address Line ';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                _addressLine2 = value;
                              },
                              controller: line2Controller,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                //Color(THEME.PRIMARY_COLOR)
                                hintText: "Address Line 2",
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white70)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              onFieldSubmitted: (term) {
                                FocusScope.of(context)
                                    .requestFocus(_stateFocus);
                              },
                              focusNode: _cityFocus,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Valid City Name ';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                _city = value;
                              },
                              controller: cityController,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                //Color(THEME.PRIMARY_COLOR)
                                hintText: "City",
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white70)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              onFieldSubmitted: (term) {
                                FocusScope.of(context).requestFocus(_zipFocus);
                              },
                              focusNode: _stateFocus,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Valid State Name';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                _state = value;
                              },
                              controller: stateController,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                //Color(THEME.PRIMARY_COLOR)
                                hintText: "State",
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white70)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Valid Zipcode ';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                _zipcode = value;
                              },
                              focusNode: _zipFocus,
                              controller: zipcodeController,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                //Color(THEME.PRIMARY_COLOR)
                                hintText: "Zip Code",
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white70)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Colors.grey[300],
                              ),
                              child: DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select Nationality';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _nationality = value;
                                  },
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: "Select Nationality",
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white70)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  items: _nations.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _nationality = value;
                                    });
                                  }),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            buttonSection(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
