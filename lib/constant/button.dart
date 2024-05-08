import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

final ButtonStyle mainButton = FilledButton.styleFrom(
    minimumSize: const Size(370, 52),
    backgroundColor: mainColor,
    textStyle: const TextStyle(fontSize: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));

final ButtonStyle secondaryButton = FilledButton.styleFrom(
    minimumSize: const Size(370, 52),
    backgroundColor: lightBlue,
    foregroundColor: mainColor,
    textStyle: const TextStyle(
      fontSize: 16,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));

final ButtonStyle dateButton = OutlinedButton.styleFrom(
    minimumSize: const Size(370, 52),
    textStyle: const TextStyle(fontSize: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));
