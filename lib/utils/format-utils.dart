import 'package:intl/intl.dart';

class FormatUtils {
  static String ZonedDateTimeFormat = 'yyyy-MM-ddTHH:mm:ss.SZ';

  static DateTime? dateFromMilliseconds(int? milliseconds) {
    return milliseconds != null ? DateTime.fromMillisecondsSinceEpoch( milliseconds ): null;
  }

  static String formatSeconds(int? secondsToString) {
    if ( secondsToString == null) return '';
    Duration dur = Duration(seconds: secondsToString);
    DateTime from = DateTime.now().subtract( dur );
    int month = from.month;
    int days = from.day;
    int hours = from.hour;
    int minutes = from.minute;
    int seconds = from.second;
    String result = '';
    if ( month > 0 ) return '${month}month ';
    if ( days > 0 ) return '${days}d ';
    if ( hours > 0 ) return '${hours}h ';
    if ( minutes > 0 ) return '${minutes}m ';
    if ( seconds > 0 ) return '${seconds}s';
    return result;
  }

  static String? dateToServerFormat(DateTime? dateTime) {
    return dateTime != null? formatDate(dateTime, ZonedDateTimeFormat): null;
  }

  static DateTime? dateFromServer(String? str) {
    return str != null? DateTime.tryParse(str): null;
  }

  static String formatDate(DateTime date, String format) {
    if ( format.contains('Z') ) {
      int minutes = date.timeZoneOffset.inMinutes;
      var sign = '+';
      if ( minutes.isNegative ) {
        minutes*=-1;
        sign = '-';
      }
      var hours = '${minutes~/60}'.padLeft(2, '0');
      final remainingMinutes = '${minutes%60}'.padLeft(2, '0');
      format = format.replaceAll('Z', '$sign$hours:$remainingMinutes');
    }
    return DateFormat( format ).format( date );
  }
}