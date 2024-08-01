import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:waveapp/services/transactions/transaction.dart';
import 'package:waveapp/utils/preference_utils.dart';

class TransactionsProvider extends ChangeNotifier {
  List<Transaction> get transactions =>
      (jsonDecode(PreferenceUtils.getString('transactions')) as List<dynamic>)
          .map((item) => Transaction.fromJson(item))
          .toList();

  void add(Transaction transaction) async {
    final transactions =
        jsonDecode(PreferenceUtils.getString('transactions')) as List<dynamic>;

    transactions.add(transaction.toJson());
    await PreferenceUtils.setString('transactions', jsonEncode(transactions));

    notifyListeners();
  }
}
