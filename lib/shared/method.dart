import 'package:intl/intl.dart';

String formatCurrency(int number, {String symbol = "Rp "}) {
  return NumberFormat.currency(locale: 'id', symbol: symbol, decimalDigits: 0)
      .format(number);
}

String stringToDateTime(String date, String format, bool? toLocal) {
  DateTime dateTime;
  if (toLocal == true) {
    dateTime = DateTime.parse(date).toLocal();
  } else {
    dateTime = DateTime.parse(date);
  }
  final formattedDateTime = DateFormat(format).format(dateTime);

  return formattedDateTime.toString();
}

String iso8601toDateTime(String iso8601String) {
  DateTime dateTime = DateTime.parse(iso8601String).toLocal();
  final formattedDateTime =
      DateFormat('EEEE, d MMMM yyyy, HH:mm').format(dateTime);

  return formattedDateTime.toString();
}

String getCurrentTimeFormatted() {
  DateTime nowUTC = DateTime.now().toUtc();
  String formattedTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(nowUTC);
  return formattedTime;
}
