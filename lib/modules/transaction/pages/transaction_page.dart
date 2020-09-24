import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voyager/modules/presentation/filter_icon_icons.dart';
import 'package:voyager/modules/login/pages/login_page.dart';
import 'package:voyager/modules/transaction/services/transaction_api.dart';
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
  void initState() {
    print('init');
    TransactionsApi().getActivityDetails();
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
            ),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: 100,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                      color: Colors.white54,
                      child: ListTile(
                        //selected: ,
                        //focusColor: isSelected? Colors.green: Colors.white,
                        onTap: () {},
                        title: Row(
                          children: [
                            Image.asset(
                              "assets/images/acural_flag.png",
                              height: 30,
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                                height: 30,
                                child: Text(
                                  'Redemption',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ))
                          ],
                        ),
                        /*Container(
                              height: 70,
                              width: 70,
                              decoration:BoxDecoration(
                          image:DecorationImage(
                          image:ExactAssetImage("assets/images/acural_flag.png")
                          ))),*/
                        subtitle: Row(
                          children: [
                            Image.asset("assets/images/redemption.png",
                                height: 20, alignment: Alignment.topLeft),
                            Container(
                                height: 20,
                                child: Text('    23-Jul-2020',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18,
                                    )))
                          ],
                        ),
                        /*Container(
                              height: 70,
                              width: 70,
                              decoration:BoxDecoration(
                              image:DecorationImage(
                                  image:ExactAssetImage("assets/images/redemption.png")
                              )))*/
                        //leading:Icon(Icons.album),
                        trailing: Column(
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Text('Redemed On HSPC',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            SizedBox(
                              height: 7,
                            ),
                            Text('-3000',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold))
                          ],
                        ),
                      )); //),
                  // );
                },
              ),
            ),
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
