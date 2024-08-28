class GiftItem {
  final int remainingDays;
  final String text;

  const GiftItem({
    required this.remainingDays,
    required this.text,
  });
}

const giftItems = [
  GiftItem(
      remainingDays: 3, text: 'Payez 1.500F ou plus chez un marchand (0/1)'),
  GiftItem(
      remainingDays: 3, text: 'Payez 1.500F ou plus chez 2 marchand (0/1)'),
  GiftItem(remainingDays: 3, text: 'Payez 1.500F ou plus chez 3 marchand (0/1)')
];
