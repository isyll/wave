import 'package:intl/intl.dart';

String formatNumber(double number, {String replace = ' '}) {
  final formatter = NumberFormat('#,##0.##########', 'en_US');
  String formattedNumber =
      formatter.format(number).replaceAll(',', replace);
  return formattedNumber;
}

int formatNumberAsFixed(double number) {
  String formattedString = number.toStringAsFixed(0);
return int.parse(formattedString);
}

