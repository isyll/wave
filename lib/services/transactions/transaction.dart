import 'package:intl/intl.dart';
import 'package:waveapp/services/transactions/transaction_status.dart';
import 'package:waveapp/services/transactions/transaction_type.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final double newBalance;
  final String? agentName;
  final Transactiontype type;
  final TransactionStatus status;
  final double fees;
  final dynamic extra;

  const Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date,
      required this.newBalance,
      required this.type,
      required this.status,
      required this.fees,
      this.extra,
      this.agentName});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        id: json['id'],
        title: json['title'],
        amount: json['amount'],
        date: DateTime.parse(
          json['date'],
        ),
        newBalance: json['newBalance'],
        type: transactionTypeFromString(json['type']),
        status: transactionStatusFromString(json['status']),
        fees: json['fees'],
        extra: json['extra']);
  }

  dynamic getExtra(String key) {
    if (extra != null) {
      return extra[key];
    }
    return null;
  }

  List<dynamic> get extraValues {
    final values = getExtra('values');
    return values ?? [];
  }

  dynamic extraValue(String name) {
    return extraValues.firstWhere(
      (value) => value['name'] == name,
      orElse: () => null,
    );
  }

  List<String> get extraDisplayBriefs {
    return extraValues
        .where((value) => value['display_brief'])
        .map((value) => value['value']) as List<String>;
  }

  bool get isLess => [
        Transactiontype.withdrawal,
        Transactiontype.transfer,
        Transactiontype.payment
      ].contains(type);

  String get formattedAmount => '${isLess ? '-' : ''}$amount';

  String formatDate(String locale) {
    final now = DateTime.now();

    if (date.year == now.year) {
      return DateFormat('d MMM HH:mm', locale).format(date);
    } else {
      return DateFormat('d MMM yyyy, HH:mm', locale).format(date);
    }
  }
}
