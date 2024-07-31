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

  static Future<List<Company>> loadCompanies() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Company.companies;
  }
}

class Company {
  static List<Company> companies = const [
    // favorites
    Company(
        name: 'Canal+',
        imgAsset: 'assets/images/logos/canalplus.png',
        bgColor: Color(0xff000000),
        isFavorite: true,
        type: CompanyType.invoice),
    Company(
        name: 'Rapido',
        imgAsset: 'assets/images/logos/rapido.png',
        bgColor: Color(0xffecd9d2),
        isFavorite: true,
        type: CompanyType.invoice),
    Company(
        name: "SEN'EAU",
        imgAsset: 'assets/images/logos/seneau.png',
        bgColor: Color(0xffeaf3d4),
        isFavorite: true,
        type: CompanyType.invoice),
    Company(
        name: 'Senelec',
        imgAsset: 'assets/images/logos/senelec.png',
        bgColor: Color(0xffe0c4db),
        isFavorite: true,
        type: CompanyType.invoice),
    Company(
        name: 'Woyofal',
        imgAsset: 'assets/images/logos/woyofal.png',
        bgColor: Color(0xfffde8e7),
        isFavorite: true,
        type: CompanyType.invoice),
    // invoices
    Company(
        name: 'Aquatech',
        imgAsset: 'assets/images/logos/aquatech.png',
        bgColor: Color(0xffdaf0f1),
        isFavorite: false,
        type: CompanyType.invoice),
    Company(
        name: 'Baobab+',
        imgAsset: 'assets/images/logos/baobabplus.png',
        bgColor: Color(0xffdbedfa),
        isFavorite: false,
        type: CompanyType.invoice),
    Company(
        name: 'Campusen',
        imgAsset: 'assets/images/logos/campusen.png',
        bgColor: Color(0xfff4eddb),
        isFavorite: false,
        type: CompanyType.invoice),
    Company(
        name: 'TNT',
        imgAsset: 'assets/images/logos/tnt.png',
        bgColor: Color(0xff0076b2),
        isFavorite: false,
        type: CompanyType.invoice),
    Company(
        name: 'UCAD',
        imgAsset: 'assets/images/logos/ucad.png',
        bgColor: Color(0xffc2f7fe),
        isFavorite: false,
        type: CompanyType.invoice),
    // Food
    Company(
        name: 'La Plancha',
        imgAsset: 'assets/images/logos/la-plancha.png',
        bgColor: Color.fromARGB(255, 231, 200, 227),
        isFavorite: false,
        type: CompanyType.food),
    Company(
        name: 'Paris Dakar',
        imgAsset: 'assets/images/logos/paris-dakar.png',
        bgColor: Color.fromARGB(255, 240, 229, 193),
        isFavorite: false,
        type: CompanyType.food),
    Company(
        name: 'Senegal Taste',
        imgAsset: 'assets/images/logos/senegal-taste.png',
        bgColor: Color.fromARGB(255, 226, 221, 222),
        isFavorite: false,
        type: CompanyType.food),
  ];

  final String name;
  final String imgAsset;
  final Color bgColor;
  final CompanyType type;
  final bool isFavorite;

  const Company(
      {required this.name,
      required this.imgAsset,
      required this.bgColor,
      required this.type,
      required this.isFavorite});
}

enum CompanyType { invoice, food, shopping, tourism }
