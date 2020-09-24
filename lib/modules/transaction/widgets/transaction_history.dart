import 'package:flutter/cupertino.dart';
import 'package:voyager/base/models/Transaction_items.dart';
import 'package:voyager/base/utils/sizeconfig.dart';
import 'package:voyager/modules/transaction/services/transactionList.dart';

class TransactionHistory extends StatefulWidget {
  TransactionHistory({Key key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  bool hasList = false;
  List<TransHistoryItems> transHistoryItems = [];
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
      child: Container(
          // height: SizeConfig.screenHeight / 2,
          height: 100,
          child: hasList
              ? Center(
                  child: Text(
                  transHistoryItems.length.toString() + " Transactions",
                  style: TextStyle(fontSize: 30),
                ))
              : Center(
                  child: Text(
                  "No Transactions",
                  style: TextStyle(fontSize: 30),
                ))),
    );
  }
}
