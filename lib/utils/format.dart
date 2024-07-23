import 'package:intl/intl.dart';

String formatNumber(double number) {
  final formatter = NumberFormat('#,##0.##########', 'en_US');
  String formattedNumber = formatter.format(number).replaceAll(',', ' ');
  return formattedNumber;
}
