import 'dart:math';

int roundToNearest5Or10(int number, double factor) {
  final reducedNumber = number * (1 + factor / 100.0);
  final remainder = reducedNumber.round() % 10;

  if (remainder <= 2 || remainder >= 8) {
    return (remainder < 5
        ? (reducedNumber / 10).floor() * 10
        : (reducedNumber / 10).ceil() * 10);
  }

  return (remainder < 5
      ? (reducedNumber / 5).floor() * 5
      : (reducedNumber / 5).ceil() * 5);
}

String generatePhoneNumber() {
  final random = Random();
  final List<String> prefixes = ['70', '75', '76', '77', '78'];
  final prefix = prefixes[random.nextInt(prefixes.length)];

  String number = '';
  for (int i = 0; i < 7; i++) {
    number += random.nextInt(10).toString();
  }

  String formattedNumber =
      '+221 $prefix ${number.substring(0, 3)} ${number.substring(3, 5)} ${number.substring(5, 7)}';

  return formattedNumber;
}
