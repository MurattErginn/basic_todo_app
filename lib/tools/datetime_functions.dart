import 'package:intl/intl.dart';

class DateTimeFunctions {
  static DateTime strToDateTime(String strDate, {String dateFormat = 'dd.MM.yyyy'}) {
    return DateFormat(dateFormat).parse(strDate);
  }

  static String getWeekDayString(DateTime date) {
    return DateFormat('EEEE').format(date).toLowerCase();
  }

  static String dateTimeToStr(DateTime dateTime, {String dateFormat = 'dd.MM.yyyy'}) {
    return DateFormat(dateFormat).format(dateTime);
  }
}