import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:waveapp/models/person_model.dart';
import 'package:waveapp/services/transactions/transaction.dart';

class DataService {
  static Future<List<Transaction>> loadTransactions() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/transactions.json');
    final jsonData = json.decode(jsonString)['data'] as List<dynamic>;

    return jsonData.map((data) => Transaction.fromJson(data)).toList();
  }

  static Future<List<Person>> loadNames() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/names.json');
    final jsonData = json.decode(jsonString)['data'] as List<dynamic>;

    return jsonData
        .map((data) =>
            Person(firstname: data['firstname'], lastname: data['lastname']))
        .toList();
  }
}
