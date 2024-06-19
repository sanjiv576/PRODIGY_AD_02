import 'package:intl/intl.dart';

class DateTimeConverter {
  String getCurrentTime() {
    return DateFormat.jm().format(DateTime.now()); // for example: 10:20 AM
  }

  String getCurrentDate() {
    return DateFormat.yMMMd()
        .format(DateTime.now()); //format example: Jun 19, 2024
  }
}
