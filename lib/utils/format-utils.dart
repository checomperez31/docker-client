import 'package:intl/intl.dart';

class FormatUtils {
  static String ZonedDateTimeFormat = 'yyyy-MM-ddTHH:mm:ss.SZ';

  static DateTime? dateFromMilliseconds(int? milliseconds) {
    return milliseconds != null ? DateTime.fromMillisecondsSinceEpoch( milliseconds ): null;
  }

  static DateTime? dateFromMillisecondsUnix(int? milliseconds) {
    return milliseconds != null ? DateTime.fromMillisecondsSinceEpoch( milliseconds * 1000 ): null;
  }

  static String formatSeconds(int? secondsToString, {String? isNull}) {
    if ( secondsToString == null) return isNull ?? '';
    Duration dur = Duration(seconds: secondsToString);
    DateTime from = DateTime.now().subtract( dur );
    int month = from.month;
    int days = from.day;
    int hours = from.hour;
    int minutes = from.minute;
    int seconds = from.second;
    String result = '';
    if ( month > 0 ) return '$month month ';
    if ( days > 0 ) return '$days d ';
    if ( hours > 0 ) return '$hours h ';
    if ( minutes > 0 ) return '$minutes m ';
    if ( seconds > 0 ) return '$seconds s';
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

  static String formatBytes(int? bytes, {String? isNull}) {
    if ( bytes == null) return isNull ?? '';
    int kb = (bytes / 1024).round();
    int mb = (kb / 1024).round();
    return '$mb MB';
  }

  static String formatBytesComplete(int? bytes, {String? isNull}) {
    if (bytes == null || bytes == 0) return '0 bytes';
    double kb = bytes / 1024;
    if (kb < 1) return '${bytes.toStringAsFixed(2)} bytes';
    double mb = kb / 1024;
    if (mb < 1) return '${kb.toStringAsFixed(2)} KB';
    double gb = mb / 1024;
    if (gb < 1) return '${mb.toStringAsFixed(2)} MB';
    double tb = gb / 1024;
    if (tb < 1) return '${gb.toStringAsFixed(2)} GB';
    return '${tb.toStringAsFixed(2)} TB';
  }
}