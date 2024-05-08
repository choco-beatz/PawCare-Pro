import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

fieldDecor(String hint) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: lightGrey, width: 1),
        borderRadius: BorderRadius.circular(16)),
    fillColor: fieldColor,
    filled: true,
    hintText: hint,
    hintStyle: const TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
  );
}
