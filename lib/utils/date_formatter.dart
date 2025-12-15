import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String formatDate(DateTime date) {
    return DateFormat('EEEE, d MMM').format(date);
  }

  static String formatDay(DateTime date) {
    return DateFormat('EEEE').format(date);
  }
}
