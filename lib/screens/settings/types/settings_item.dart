import 'package:flutter/material.dart';

class SettingsItem {
  const SettingsItem(
      {required this.icon,
      required this.title,
      this.subTitle,
      required this.actionRoute});

  final Widget icon;
  final String title;
  final String? subTitle;
  final String actionRoute;
}
