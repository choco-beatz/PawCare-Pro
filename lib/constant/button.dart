import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

final ButtonStyle mainButton = FilledButton.styleFrom(
    minimumSize: const Size(370, 52),
    backgroundColor: mainColor,
    textStyle: const TextStyle(fontSize: 18),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));

final ButtonStyle secondaryButton = FilledButton.styleFrom(
    minimumSize: const Size(370, 52),
    backgroundColor: lightBlue,
    foregroundColor: mainColor,
    textStyle: const TextStyle(
      fontSize: 18,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));

final ButtonStyle dateButton = OutlinedButton.styleFrom(
    minimumSize: const Size(370, 52),
    textStyle: const TextStyle(fontSize: 18),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));

final ButtonStyle cancelButton = FilledButton.styleFrom(
    backgroundColor: mainColor,
    textStyle: const TextStyle(fontSize: 18, color: white),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));

final ButtonStyle delButton = FilledButton.styleFrom(
    backgroundColor: Colors.red,
    textStyle: const TextStyle(fontSize: 18, color: white),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));
