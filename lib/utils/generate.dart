import 'dart:math';

import 'package:waveapp/services/transactions/transaction.dart';
import 'package:waveapp/services/transactions/transaction_status.dart';
import 'package:waveapp/services/transactions/transaction_type.dart';

Transaction generateTransaction(
    {required String title,
    required double amount,
    required Transactiontype type}) {
  return Transaction(
      id: generateRandomId(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      newBalance: generateRandomInt(5000, 25000).toDouble(),
      type: type,
      status: TransactionStatus.completed,
      fees: 0.0);
}

String generateRandomId([int length = 13]) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
}

int generateRandomInt(int min, int max) {
  Random random = Random();
  return min + random.nextInt(max - min + 1);
}

Transactiontype getRandomTransactionType() {
  final random = Random();
  const values = Transactiontype.values;
  return values[random.nextInt(values.length)];
}
