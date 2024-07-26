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
