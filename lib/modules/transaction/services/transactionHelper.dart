import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:voyager/base/models/charity_model.dart';
import 'package:voyager/modules/transaction/services/transactionList.dart';

class TransactionHelper {
  List<CharityModel> charityList = [];

  getCharities() async {
    List<dynamic> charities =
        await parseJsonFromAssets('assets/files/charities.json');
    List<String> values = [];
    List<String> keys = [];
    charities.forEach((element) {
      for (var value in element.values) {
        values.add(value);
      }
      for (var key in element.keys) {
        keys.add(key);
      }
    });

    for (int i = 0; i < values.length; i++) {
      CharityModel model = new CharityModel(keys[i], values[i]);
      charityList.add(model);
    }
    print(charityList.length);
  }

  Future<List<dynamic>> parseJsonFromAssets(String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  getCharityNameFromCharityNumber(String charityNumber) async {
    await getCharities();
    String name = charityNumber;
    try {
      charityList.forEach((element) {
        if (element.charityAccNum == charityNumber) {
          name = element.charityName;
          TransactionList.charityName = name;
        }
      });
    } on Exception catch (e) {
      print("error in getcharityname");
      print(e.toString());
      TransactionList.charityName = name;
    }
    TransactionList.charityName = name;
    print(TransactionList.charityName);
  }
}
