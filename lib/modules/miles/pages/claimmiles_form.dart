import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class ClaimMilesForm extends StatefulWidget {
  final i;
  ClaimMilesForm({Key key, this.i}) : super(key: key);
  @override
  _ClaimMilesFormState createState() => _ClaimMilesFormState();
}

class _ClaimMilesFormState extends State<ClaimMilesForm> {
  final formKey = new GlobalKey<FormState>();
  void initState() {
    _setupCabin();
    _setupBooking();
    super.initState();
  }

  List partnerName = [
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
  final TextEditingController flightDateController =
      new TextEditingController();
  final TextEditingController flightNumberController =
      new TextEditingController();
  final TextEditingController eTicketNumberController =
      new TextEditingController();

  final FocusNode _flightNumberFocus = FocusNode();
  final FocusNode _eTicketNumberFocus = FocusNode();
  final FocusNode _flightDateFocus = FocusNode();

  String _flightDate = "Select Flight Date";
  String _flightNumber;
  String _eTicketNumber;

  List _cabinClassTitles = [];
  List _bookingClassTitles = [];

  _setupCabin() async {
    List<String> cabinClass = await _getCabinClass();
    setState(() {
      _cabinClassTitles = cabinClass;
    });
  }

  _setupBooking() async {
    List<String> bookingClass = await _getBookingClass();
    setState(() {
      _bookingClassTitles = bookingClass;
    });
  }

  _submitForm() {
    var form = formKey.currentState;
    Map data = {
      'eTicketNumber': _eTicketNumber,
      'flightNumber': _flightNumber,
      'flightDate': _flightDate,
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
        title: Text('Claim Miles'),
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Center(
                    child: Text(partnerName[widget.i],
                        style: TextStyle(fontSize: 18)),
                  )),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Text(
                  'For your Miles to track systematically, simply quote your unique SAA Voyager membership number during the booking process or at point of sale. Missing miles for Star Alliance airlines, SAA, SA Express and Airlink can be claimed by going to Claim Miles page. Missing miles for all other partners can be claimed via the Voyager Service Center.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      'Please enter your ${partnerName[widget.i]} e-ticket number.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
              _buildForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
        key: formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildeTicket(),
            _buildFlightNumber(),
            _buildFlightDate(context),
            _buildcabinClass(),
            _buildbookingClass(),
            _buildOrigin(),
            _buildDestination(),
            _buildSubmitButton(context),
          ],
        ));
  }

  Widget _buildeTicket() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter eTicket Number';
            }
            return null;
          },
          onSaved: (String value) {
            _eTicketNumber = value;
          },
          controller: eTicketNumberController,
          onFieldSubmitted: (term) {
            FocusScope.of(context).requestFocus(_eTicketNumberFocus);
          },
          decoration: InputDecoration(
            labelText: 'Enter e-Ticket Number',
            suffixIcon: Icon(Icons.confirmation_number),
          )),
    );
  }

  Widget _buildFlightNumber() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter Flight Number';
          }
          return null;
        },
        onSaved: (String value) {
          _flightNumber = value;
        },
        controller: flightNumberController,
        onFieldSubmitted: (term) {
          FocusScope.of(context).requestFocus(_flightNumberFocus);
        },
        decoration: InputDecoration(
          labelText: 'Enter Flight Number',
          suffixIcon: Icon(Icons.local_airport),
        ),
      ),
    );
  }

  Widget _buildFlightDate(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          focusNode: _flightDateFocus,
          decoration: InputDecoration(
              labelText: 'Select Flight Date',
              suffixIcon: Icon(Icons.event_available)),
          onTap: () async {
            FocusScope.of(context).requestFocus(new FocusNode());
            final datePick = await showRoundedDatePicker(
                height: 280,
                theme: ThemeData(
                  primaryColor: Colors.black,
                  accentColor: Color(THEME.BUTTON_COLOR),
                  dialogBackgroundColor: Colors.grey[300],
                ),
                context: context,
                initialDate: new DateTime.now(),
                firstDate: new DateTime(1990),
                lastDate: new DateTime.now());

            if (datePick != null) {
              setState(() {
                flightDateController.text =
                    "${datePick.month}/${datePick.day}/${datePick.year}";
              });
            }
          },
          onChanged: (value) {
            setState(() {
              _flightDate = "Select Flight Date";
            });
          },
          onSaved: (String value) {},
          controller: flightDateController,
          cursorColor: Colors.black,
          style: TextStyle(color: Colors.black),
        ));
  }

  Widget _buildcabinClass() {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[200],
        ),
        child: DropdownButtonFormField(
          iconSize: 0.0,
          validator: (value) {
            if (value == null) {
              return 'Select Cabin Class';
            }
            return null;
          },
          onSaved: (value) {
            _cabinClassTitles = value;
          },
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: "Select Cabin Class",
              suffixIcon: Icon(Icons.airline_seat_recline_normal)),
          items: _cabinClassTitles.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _cabinClassTitles = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildbookingClass() {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[200],
        ),
        child: DropdownButtonFormField(
          iconSize: 0.0,
          validator: (value) {
            if (value == null) {
              return 'Select Booking Class';
            }
            return null;
          },
          onSaved: (value) {
            _bookingClassTitles = value;
          },
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: "Select Booking Class",
              suffixIcon: Icon(Icons.airline_seat_legroom_normal)),
          items: _bookingClassTitles.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _bookingClassTitles = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildOrigin() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Enter Origin',
              suffixIcon: Icon(Icons.flight_takeoff)),
        ));
  }

  Widget _buildDestination() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Enter Destination',
              suffixIcon: Icon(Icons.flight_land)),
        ));
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 20.0, bottom: 30),
      height: 40.0,
      child: RaisedButton(
        child: Text(
          'SUBMIT',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        onPressed: _submitForm,
        textColor: Colors.white,
        elevation: 0.0,
        color: Color(THEME.BUTTON_COLOR),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  Future<List<String>> _getBookingClass() async {
    String text;
    List<String> bookingClassList = [];
    try {
      text = await rootBundle.loadString('assets/files/bookingclass.txt');
      bookingClassList = text.split('\n');
    } catch (e) {
      print("Couldn't read file");
    }
    return bookingClassList;
  }

  Future<List<String>> _getCabinClass() async {
    String text;
    List<String> cabinClassList = [];
    try {
      text = await rootBundle.loadString('assets/files/cabinclass.txt');
      cabinClassList = text.split('\n');
    } catch (e) {
      print("Couldn't read file");
    }
    return cabinClassList;
  }
}