import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

final fieldRadio = ButtonStyle(
    foregroundColor: MaterialStateColor.resolveWith((states) => Colors.green),
    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: lightGrey, width: 1))),
    backgroundColor: const MaterialStatePropertyAll(fieldColor));

const line = Divider(
  thickness: 1.5,
  color: grey,
  height: 25,
);
