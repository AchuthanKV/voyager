import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/screens/login_page.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class CarVoucher extends StatefulWidget {
  @override
  _CarVoucherState createState() => _CarVoucherState();
}

class _CarVoucherState extends State<CarVoucher> {
  final formKey = new GlobalKey<FormState>();

  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController pickupDateController =
      new TextEditingController();
  final TextEditingController reservationController =
      new TextEditingController();

  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _pickupDateFocus = FocusNode();

  List _select = ['First', 'Second', 'Third', 'Fourth'];
  List _selectGroup = ['Group1', 'Group2', 'Group3', 'Group4'];
  List _selectOption = ['Option1', 'Option2', 'Option3', 'Option4'];
  String _reservationNumber;
  String _lastName;
  String _pickupDate = "Pick Up Date";
  List _pickupLocation = [
    'Johannesburg',
    'Cape Town',
    'Pretoria',
    'Bloemfontein'
  ];
  bool _isChecked = false;

  _saveForm() {
    var form = formKey.currentState;
    Map data = {
      'select': _select,
      'reservationNumber': _reservationNumber,
      'lastname': _lastName,
      'pickupDate': _pickupDate,
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
      resizeToAvoidBottomInset: false,
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
        child: Form(
          key: formKey,
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
                      _select = value;
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
                    items: _select.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _select = value;
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
                      _selectGroup = value;
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
                    items: _selectGroup.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectGroup = value;
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
                        return 'Select Option';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _selectOption = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Select Option",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    items: _selectOption.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectOption = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Reservation Number';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    _reservationNumber = value;
                  },
                  controller: reservationController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Reservation Number",
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Last Name';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    _lastName = value;
                  },
                  controller: lastNameController,
                  onFieldSubmitted: (term) {
                    FocusScope.of(context).requestFocus(_lastNameFocus);
                  },
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Last Name",
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(THEME.PRIMARY_COLOR))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(color: Colors.grey),
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
                        return 'Pick Up Location';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _pickupLocation = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Pick Up Location",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    items: _pickupLocation.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _pickupLocation = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  focusNode: _pickupDateFocus,
                  readOnly: true,
                  validator: (value) {
                    if (_pickupDate == "Pick Up Date") {
                      return 'Please select a pick up date';
                    }
                    return null;
                  },
                  onTap: () async {
                    final datePick = await showDatePicker(
                        context: context,
                        initialDate: new DateTime.now(),
                        firstDate: new DateTime(1990),
                        lastDate: new DateTime.now());
                    if (datePick != null) {
                      setState(() {
                        _pickupDate =
                            "${datePick.month}/${datePick.day}/${datePick.year}";
                      });
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      _pickupDate = "Pick Up Date";
                    });
                  },
                  onSaved: (String value) {},
                  controller: pickupDateController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: _pickupDate,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(color: Colors.grey),
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
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
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
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
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
                        print("value of your booking");
                      },
                    ),
                  ),
                ],
              )),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                margin: EdgeInsets.only(top: 10.0, bottom: 30),
                height: 40.0,
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
