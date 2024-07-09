import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

AppBar normalAppBar(String text) {
  return AppBar(
    backgroundColor: mainBG,
    foregroundColor: white,
    title: Text(
      text,
      style: TextStyle(fontSize: 18),
    ),
  );
}
