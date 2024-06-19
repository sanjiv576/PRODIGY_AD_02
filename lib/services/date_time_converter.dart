import 'package:intl/intl.dart';

class DateTimeConverter {
 static String getCurrentTime() {
    return DateFormat.jm().format(DateTime.now()); // for example: 10:20 AM
  }

 static String getCurrentDate() {
    return DateFormat.yMMMd()
        .format(DateTime.now()); //format example: Jun 19, 2024
  }
}
