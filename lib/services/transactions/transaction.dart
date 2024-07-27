import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waveapp/services/transactions/transaction_status.dart';
import 'package:waveapp/services/transactions/transaction_type.dart';
import 'package:waveapp/utils/format.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  String get formattedAmount =>
      '${isLess ? '-' : ''}${formatNumber(amount, replace: '.')}F';
  String get formattedNewBalance =>
      '${formatNumber(newBalance, replace: '.')}F';
  String get formattedFees =>
      '${fees == 0.0 ? 0 :formatNumber(fees, replace: '.')}F';

  String statusToString(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    switch (status) {
      case TransactionStatus.completed:
        return l.transaction_status_completed;
      case TransactionStatus.failed:
        return l.transaction_status_failed;
      case TransactionStatus.canceled:
        return l.transaction_status_canceled;
      case TransactionStatus.onHold:
        return l.transaction_status_onhold;
      case TransactionStatus.inProgress:
        return l.transaction_status_inprogress;
      default:
        throw ArgumentError('Invalid transaction status: $status');
    }
  }

  String formatDate(String locale) {
    final now = DateTime.now();

    if (date.year == now.year) {
      return DateFormat('d MMM HH:mm', locale).format(date);
    } else {
      return DateFormat('d MMM yyyy, HH:mm', locale).format(date);
    }
  }
}
