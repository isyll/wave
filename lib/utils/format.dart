import 'package:intl/intl.dart';

String formatNumber(double number, {String replace = ' '}) {
  final formatter = NumberFormat('#,##0.##########', 'en_US');
  String formattedNumber = formatter.format(number).replaceAll(',', replace);
  return formattedNumber;
}

int formatNumberAsFixed(double number) {
  String formattedString = number.toStringAsFixed(0);
  return int.parse(formattedString);
}

String formatPhoneNumber(String phoneNumber) {
  final RegExp regExp = RegExp(r'(\+\d{3})(\d{2})(\d{3})(\d{2})(\d{2})');
  return phoneNumber.replaceAllMapped(regExp, (Match match) {
    return '${match.group(1)} ${match.group(2)} ${match.group(3)} ${match.group(4)} ${match.group(5)}';
  });
}

String applyPhoneFormatting(String text) {
  text = text.replaceAll(' ', '');

  if (text.length > 9) {
    text = text.substring(0, 9);
  }

  StringBuffer buffer = StringBuffer();
  for (int i = 0; i < text.length; i++) {
    if (i == 2 || i == 5 || i == 7) {
      buffer.write(' ');
    }
    buffer.write(text[i]);
  }
  return buffer.toString();
}
