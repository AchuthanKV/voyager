import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/base/models/Transaction_items.dart';
import 'package:voyager/base/utils/sizeconfig.dart';
import 'package:voyager/modules/transaction/services/transactionList.dart';
import 'package:voyager/services/background.dart';

class TransactionHistory extends StatefulWidget {
  TransactionHistory({Key key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  bool hasList = false;
  List<TransHistoryItems> transHistoryItems = [];
  ScrollController _controller = new ScrollController();
  go() {
    transHistoryItems = TransactionList().setTransactionList();

    if (transHistoryItems.isNotEmpty) {
      setState(() {
        hasList = true;
      });
    } else {
      setState(() {
        hasList = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    go();
    return SingleChildScrollView(
        child: hasList
            ? ListView.builder(
                controller: _controller,
                itemCount: transHistoryItems.length,
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
                              "assets/images/${transHistoryItems[index].activityImageFlag}",
                              height: 30,
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                                height: 30,
                                child: Text(
                                  transHistoryItems[index].activityName,
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
                            Image.asset(
                                "assets/images/${transHistoryItems[index].activityImage}",
                                height: 20,
                                alignment: Alignment.topLeft),
                            Container(
                                height: 20,
                                child: Text(
                                    '    ${transHistoryItems[index].activityDate}',
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
                            Container(
                              width: SizeConfig.screenWidth / 3 + 20,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                    '${transHistoryItems[index].activityDescription}',
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text('${transHistoryItems[index].activityPoints}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold))
                          ],
                        ),
                      )); //),
                  // );
                },
              )
            : Container(
                height: SizeConfig.screenHeight / 2,
                child: Center(
                    child: Text(
                  "No Transactions",
                  style: TextStyle(fontSize: 30),
                )),
              ));
  }
}
