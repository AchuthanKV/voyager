import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:voyager/base/models/profile_model.dart';
import 'package:voyager/modules/login/services/loginuser.dart';
import 'package:voyager/modules/my-profile/services/update_user.dart';
import 'package:voyager/services/background.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class Address extends StatefulWidget {
  Address({Key key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _signupFormKey = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool isSignUp = false;
  bool signedUp = false;
  bool isEmailOn = false;
  bool isNotificationOn = false;
  ProfileModel profileObject = LoginUser.profileModel;

  List<String> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

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
  final TextEditingController countryCodeController =
      new TextEditingController();

  String _addressLine1;
  String _addressLine2;
  String _city;
  String _state;
  String _zipcode;
  String _email;
  String _phone;
  String _areacode;
  String _isdcode;
  String _countryCode = "77";

  String _nationality;
  List _locations = ['+91', '72'];
  List<String> _nations = [];
  List _genders = ['Male', 'Female'];
  List _country_code = ['jk'];

  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _mailFocus = FocusNode();
  final FocusNode _line1Focus = FocusNode();
  final FocusNode _line2Focus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _zipFocus = FocusNode();

  setDefaultValues() {
    line1Controller.text = profileObject.addressLine1;
    line2Controller.text = profileObject.addressLine2;
    cityController.text = profileObject.city;
    stateController.text = profileObject.state;
    zipcodeController.text = profileObject.zipCode;

    emailController.text = profileObject.emailAddress;
    phoneController.text = profileObject.mobileNumber;
    areaController.text = profileObject.mobileAreaCode;
    _countryCode = profileObject.mobileISDCode;
    _nationality = profileObject.memberNationality;
  }

  firstCharacterUpper(String text) {
    List arrayPieces = List();
    String outPut = "";
    text.split(' ').forEach((sepparetedWord) {
      arrayPieces.add(sepparetedWord);
    });

    arrayPieces.forEach((word) {
      if (word[0] != null)
        word =
            "${word[0].toString().toUpperCase()}${word.toString().substring(1)} ";
      outPut += word;
    });

    return outPut;
  }

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  getCountries() async {
    List<String> country = [];
    List<String> code = [];
    List<String> countryCode = [];
    Map<String, dynamic> dmap =
        await parseJsonFromAssets('assets/files/countries.json');
    dmap["countries"].forEach((element) {
      for (var value in element.values) {
        country.add(firstCharacterUpper(value.toLowerCase()));
      }
      for (var key in element.keys) {
        code.add(key);
      }
    });
    for (int i = 0; i < code.length; i++) {
      String item = country[i] + " (" + code[i] + ")";
      countryCode.add(item);
    }
    setState(() {
      _nations = countryCode;
    });
  }

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
              onPressed: () async {
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
                    'countryCode': _countryCode,
                  };

                  // LoginUser.profileModel.addressLine1 = _addressLine1;
                  // LoginUser.profileModel.addressLine2 = _addressLine2;
                  // LoginUser.profileModel.city = _city;
                  // LoginUser.profileModel.state = _state;
                  // LoginUser.profileModel.country = _nationality;
                  // LoginUser.profileModel.zipCode = _zipcode;
                  // LoginUser.profileModel.mobileAreaCode = _areacode;
                  // LoginUser.profileModel.mobileNumber = _phone;
                  // LoginUser.profileModel.mobileISDCode = _countryCode;
                  // LoginUser.profileModel.emailAddress = _email;

                  // print(data);
                  setState(() {
                    _isLoading = true;
                  });
                  String status =
                      await UpdateUser().updateUser(data, _scaffold);
                  if (status == "true") {
                    line1Controller.clear();
                    line2Controller.clear();
                    cityController.clear();
                    stateController.clear();
                    zipcodeController.clear();

                    emailController.clear();
                    phoneController.clear();
                    areaController.clear();
                    _countryCode = profileObject.mobileISDCode;
                    _nationality = profileObject.memberNationality;
                  }
                  setState(() {
                    _isLoading = false;
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

  void initState() {
    _setup();

    setDefaultValues();
    //  getCountries();
    super.initState();
    // _countryCode = null;
    emailController.addListener(() {
      final text = emailController.text.toLowerCase();
      emailController.value = emailController.value.copyWith(
        text: text,
        // selection:
        //     TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  _setup() async {
    // Retrieve the country code (Processed in the background)
    List<String> countryCode = await getCountryCode();

    // Notify the UI and display the country code
    setState(() {
      _country_code = countryCode;
    });
  }

  void materialPicker() {
    showMaterialSelectionPicker(
      context: context,
      title: "Choose Country Code",
      items: _country_code,
      selectedItem: _countryCode,
      onChanged: (value) => setState(() => _countryCode = value),
    );
  }

  void materialPicker1() {
    showMaterialSelectionPicker(
      context: context,
      title: "Choose Nationality",
      items: _nations,
      selectedItem: _nationality,
      onChanged: (value) => setState(() => _nationality = value),
    );
  }

  Future<List<String>> getCountryCode() async {
    List<String> countryCode = [];
    await rootBundle.loadString('assets/files/country_code.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        countryCode.add(i);
      }
    });

    return countryCode;
  }

  @override
  Widget build(BuildContext context) {
    getCountries();
    return Scaffold(
        key: _scaffold,
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
              _isLoading
                  ? Center(
                      child: SpinKitCubeGrid(
                        color: Colors.black,
                        size: 100.0,
                      ),
                    )
                  : SingleChildScrollView(
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
                          // SimpleAutoCompleteTextField(
                          //   // decoration: new InputDecoration(errorText: "Beans"),
                          //   controller: TextEditingController(text: _nationality),
                          //   suggestions: _nations,

                          //   textChanged: (text) => _nationality = text,
                          //   // _nationality = text,

                          //   clearOnSubmit: false,
                          //   key: key,
                          //   textSubmitted: (text) => setState(() {
                          //     if (text != "") {
                          //       _nationality = text;
                          //     }
                          //   }),
                          // ),
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
                                          child: TextFormField(
                                            readOnly: true,
                                            validator: (value) {
                                              if (_countryCode == null ||
                                                  _countryCode.isEmpty) {
                                                return 'Please select a Country Code';
                                              }
                                              return null;
                                            },
                                            onSaved: (String value) {
                                              _countryCode =
                                                  _countryCode.replaceAll(
                                                      new RegExp(r'[^0-9]'),
                                                      '');
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                _countryCode =
                                                    _countryCode.replaceAll(
                                                        new RegExp(r'[^0-9]'),
                                                        '');
                                              });
                                            },
                                            onTap: () {
                                              materialPicker();
                                            },
                                            controller: countryCodeController,
                                            cursorColor: Colors.white70,
                                            style:
                                                TextStyle(color: Colors.black),
                                            decoration: InputDecoration(
                                              hintText: _countryCode.replaceAll(
                                                  new RegExp(r'[^0-9]'), ''),
                                              border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white70)),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
                                              //Color(THEME.PRIMARY_COLOR)
                                            ),
                                          )),
                                      Expanded(
                                        flex: 2,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter a Area Code';
                                            }
                                            return null;
                                          },
                                          onSaved: (String value) {
                                            _areacode = value;
                                          },
                                          onChanged: (value) {
                                            _areacode = value;
                                          },
                                          controller: areaController,
                                          cursorColor: Colors.white70,
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
                                            //Color(THEME.PRIMARY_COLOR)
                                          ),
                                        ),
                                      ),
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
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
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
                                          borderSide: BorderSide(
                                              color: Colors.white70)),
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
                                              color:
                                                  Color(THEME.PRIMARY_COLOR))),
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
                                      FocusScope.of(context)
                                          .requestFocus(_cityFocus);
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
                                          borderSide: BorderSide(
                                              color: Colors.white70)),
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
                                          borderSide: BorderSide(
                                              color: Colors.white70)),
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
                                          .requestFocus(_zipFocus);
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
                                          borderSide: BorderSide(
                                              color: Colors.white70)),
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
                                          borderSide: BorderSide(
                                              color: Colors.white70)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  TextFormField(
                                    readOnly: true,
                                    validator: (value) {
                                      if (_nationality == null ||
                                          _nationality.isEmpty) {
                                        return 'Please select Nationlity';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      _nationality = _nationality;
                                    },
                                    onChanged: (value) {
                                      // setState(() {
                                      //   _countryCode =
                                      //       _countryCode.replaceAll(
                                      //           new RegExp(r'[^0-9]'), '');
                                      // });
                                    },
                                    onTap: () {
                                      materialPicker1();
                                    },
                                    controller: nationalityController,
                                    cursorColor: Colors.white70,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: _nationality,
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white70)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      hintStyle: TextStyle(color: Colors.black),
                                      //Color(THEME.PRIMARY_COLOR)
                                    ),
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
