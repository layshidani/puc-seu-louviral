import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static String fromTimeStamp(timestamp) {
    DateTime datetime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    final outputFormat = DateFormat('MM/dd/yyyy HH:mm');
    return outputFormat.format(datetime);
  }
}
