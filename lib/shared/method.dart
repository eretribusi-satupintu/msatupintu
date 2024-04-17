import 'package:intl/intl.dart';

String formatCurrency(num number, {String symbol = "Rp "}) {
  return NumberFormat.currency(locale: 'id', symbol: symbol, decimalDigits: 0)
      .format(number);
}

String iso8601toDateTime(String iso8601String) {
  DateTime dateTime = DateTime.parse(iso8601String).toLocal();
  final formattedDateTime =
      DateFormat('EEEE, d MMMM yyyy, HH:mm').format(dateTime);

  return formattedDateTime.toString();
}
