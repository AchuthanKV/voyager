import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:voyager/base/models/charity_model.dart';
import 'package:voyager/base/utils/sizeconfig.dart';
import 'package:voyager/modules/presentation/filter_icon_icons.dart';
import 'package:voyager/modules/transaction/services/transactionHelper.dart';
import 'package:voyager/modules/transaction/services/transaction_api.dart';
import 'package:voyager/modules/transaction/widgets/transaction_history.dart';
import 'package:voyager/theme/theme.dart' as THEME;
import 'package:flutter/cupertino.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({Key key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final List<String> items = <String>[
    '10 Days',
    '15 Days',
    '20 Days',
    'Select Date Range'
  ];
  bool isloading = true;
  String selectedItem = '10 Days';
  bool selectRange = false;
  bool isSelected = false;
  Map<int, Color> color = {
    50: Color.fromRGBO(4, 131, 184, .1),
    100: Color.fromRGBO(4, 131, 184, .2),
    200: Color.fromRGBO(4, 131, 184, .3),
    300: Color.fromRGBO(4, 131, 184, .4),
    400: Color.fromRGBO(4, 131, 184, .5),
    500: Color.fromRGBO(4, 131, 184, .6),
    600: Color.fromRGBO(4, 131, 184, .7),
    700: Color.fromRGBO(4, 131, 184, .8),
    800: Color.fromRGBO(4, 131, 184, .9),
    900: Color.fromRGBO(4, 131, 184, 1),
  };
  DateTime fromDate = DateTime.now().subtract(new Duration(days: 10));
  DateTime toDate = DateTime.now();
  final TextEditingController fromController = new TextEditingController();
  final TextEditingController toController = new TextEditingController();

  void initState() {
    getTransactionData(fromDate, toDate);
  }

  Future<void> getTransactionData(DateTime fromDate, DateTime toDate) async {
    final f = new DateFormat('dd-MMM-yyyy hh:mm:ss');
    await TransactionHelper().getCharities();
    String from = f.format(fromDate).toString();
    String to = f.format(toDate).toString();
    await TransactionsApi().getActivityDetails(from, to);

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          /* Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => MilesInfoPage()));*/
          //print(DateTime.now().subtract(Duration(days: int.parse("10"))));
          // print(DateFormat("dd-MMM-yyyy HH:mm:ss").format(DateTime.now()));
        },
        tooltip: 'Increment',
        child: ImageIcon(
          AssetImage("assets/images/mails.png"),
          size: 40,
        ),
        elevation: 2.0,
      ),
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Transactions'),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Text('Filter')
                DropdownButton(
                  underline: SizedBox(),
                  value: _selectedValue(),
                  onChanged: (String string) {
                    switch (string) {
                      case "10 Days":
                        fromDate =
                            DateTime.now().subtract(new Duration(days: 10));

                        break;
                      case "15 Days":
                        fromDate =
                            DateTime.now().subtract(new Duration(days: 15));
                        break;

                      case "20 Days":
                        fromDate =
                            DateTime.now().subtract(new Duration(days: 20));
                        break;
                      case "Select Date Range":
                        setState(() {
                          selectedItem = string;
                          selectRange = true;
                        });
                    }
                    if (string != "Select Date Range") {
                      toDate = DateTime.now();

                      setState(() {
                        isloading = true;
                        selectedItem = string;
                        selectRange = false;
                      });
                      getTransactionData(fromDate, toDate);
                    } else {
                      toDate = DateTime.now();

                      fromDate =
                          DateTime.now().subtract(new Duration(days: 10));
                      toController.text =
                          "${toDate.month}/${toDate.day}/${toDate.year}";
                      fromController.text =
                          "${fromDate.month}/${fromDate.day}/${fromDate.year}";
                    }

                    isSelected = true;
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return items.map<Widget>((String item) {
                      switch (item) {
                        case "10 Days":
                          return Text("10");
                        case "15 Days":
                          return Text("15");
                        case "20 Days":
                          return Text("20");

                        case "Select Date Range":
                          return Text("Date");
                      }
                    }).toList();
                  },
                  icon: Icon(
                    FilterIcon.filter,
                    color: Colors.black,
                    size: 45,
                  ),
                  dropdownColor: Colors.grey,
                  //hint: Text('Filter by days'),
                  //color: Colors.white,
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item',
                          style: TextStyle(
                              backgroundColor: Colors.grey,
                              fontWeight: FontWeight.bold)),
                      value: item,
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            selectRange
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: fromController,
                          readOnly: true,
                          onTap: () async {
                            final datePick = await showRoundedDatePicker(
                              height: 280,
                              context: context,
                              background: Colors.transparent,
                              initialDate: fromDate != null
                                  ? new DateTime(fromDate.year, fromDate.month,
                                      fromDate.day)
                                  : new DateTime.now(),
                              firstDate: new DateTime(1900),
                              lastDate: toDate != null
                                  ? new DateTime(
                                      toDate.year, toDate.month, toDate.day)
                                  : new DateTime.now(),
                              theme: ThemeData(
                                primaryColor: Colors.black,
                                primarySwatch: MaterialColor(0xFF000000, color),
                                accentColor: Color(THEME.BUTTON_COLOR),
                                dialogBackgroundColor: Colors.grey[300],
                                textTheme: TextTheme(
                                  body1: TextStyle(color: Colors.black),
                                  caption: TextStyle(color: Colors.black),
                                ),
                                disabledColor: Colors.grey,
                                accentTextTheme: TextTheme(
                                  body2: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                            if (datePick != null) {
                              setState(() {
                                fromController.text =
                                    "${datePick.month}/${datePick.day}/${datePick.year}";
                                fromDate = datePick;
                              });
                            }
                          },
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            icon:
                                Icon(Icons.calendar_today, color: Colors.black),
                            hintText: "From Date",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: toController,
                          readOnly: true,
                          onTap: () async {
                            final datePick = await showRoundedDatePicker(
                              height: 280,
                              context: context,
                              background: Colors.transparent,
                              initialDate: toDate != null
                                  ? new DateTime(
                                      toDate.year, toDate.month, toDate.day)
                                  : new DateTime.now(),
                              firstDate: fromDate != null
                                  ? new DateTime(fromDate.year, fromDate.month,
                                      fromDate.day)
                                  : new DateTime(1900),
                              lastDate: new DateTime.now(),
                              theme: ThemeData(
                                primaryColor: Colors.black,
                                primarySwatch: MaterialColor(0xFF000000, color),
                                accentColor: Color(THEME.BUTTON_COLOR),
                                dialogBackgroundColor: Colors.grey[300],
                                textTheme: TextTheme(
                                  body1: TextStyle(color: Colors.black),
                                  caption: TextStyle(color: Colors.black),
                                ),
                                disabledColor: Colors.grey,
                                accentTextTheme: TextTheme(
                                  body2: TextStyle(color: Colors.black),
                                  caption: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                            if (datePick != null) {
                              setState(() {
                                toController.text =
                                    "${datePick.month}/${datePick.day}/${datePick.year}";
                                toDate = datePick;
                              });
                            }
                          },
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            icon:
                                Icon(Icons.calendar_today, color: Colors.black),
                            hintText: "To Date",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(8),
                          child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  isloading = true;
                                });
                                getTransactionData(fromDate, toDate);
                              },
                              color: Color(THEME.BUTTON_COLOR),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Show"),
                              )),
                        ),
                      )
                    ],
                  )
                : SizedBox(
                    height: 0,
                  ),
            SizedBox(
              height: 30,
            ),
            Table(
              // border: TableBorder.all(width: 1),
              columnWidths: {
                0: FractionColumnWidth(.4),
                1: FractionColumnWidth(.2),
                2: FractionColumnWidth(.4)
              },
              children: [
                TableRow(children: [
                  Column(children: [
                    Text(
                      ' Available Miles',
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ]),
                  Column(children: [
                    Container(
                        height: 35,
                        child: VerticalDivider(
                          color: Colors.black,
                          width: 20,
                        )),
                  ]),
                  Column(children: [
                    Center(
                        child: Text(
                      'Tier Miles',
                      style: TextStyle(
                        fontSize: 19,
                      ),
                      textAlign: TextAlign.center,
                    ))
                  ]),
                ]),
              ],
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              color: Colors.black,
            ),
            isloading
                ? Column(
                    children: [
                      Container(
                        height: SizeConfig.screenHeight / 3,
                        child: Center(
                          child: SpinKitCubeGrid(
                            color: Colors.black26,
                            size: 100.0,
                          ),
                        ),
                      ),
                      Text(
                        'Loading...!!',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  )
                : Expanded(child: TransactionHistory()),
          ],
        ),
      ),
    );
    //);
  }

  String _selectedValue() {
    if (!isSelected) {
      print('default service call with ' + selectedItem);
    }
    return selectedItem;
  }
}
