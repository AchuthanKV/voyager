import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/modules/presentation/filter_icon_icons.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class TransactionPage extends StatefulWidget {
  TransactionPage({Key key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final List<String> items = <String>['10', '15', '20'];
  String selectedItem = '10';
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Transactions'),
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
                    print(string);
                    isSelected = true;
                    print('Item is selected : $isSelected');
                    setState(() {
                      selectedItem = string;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return items.map<Widget>((String item) {
                      return Text(item);
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
                      child: Text('$item Days',
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
              height: 20,
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
                    )
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
            )
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
