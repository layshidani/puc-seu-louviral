// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DateTimeHelper {
  static String fromTimeStamp(timestamp) {
    DateTime datetime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    final outputFormat = DateFormat('MM/dd/yyyy HH:mm');
    return outputFormat.format(datetime);
  }
}
