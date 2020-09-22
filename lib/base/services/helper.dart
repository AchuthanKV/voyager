import 'package:intl/intl.dart';

class Helper {
  static String getFormatedTime() {
    DateTime date = new DateTime.now();
    DateFormat zuluTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

    return zuluTime.format(date);
  }
}
