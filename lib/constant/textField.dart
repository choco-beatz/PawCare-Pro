import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/colors.dart';

fieldDecor(String hint) {
  return InputDecoration(
    focusColor: Colors.white,
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: lightGrey, width: 1),
        borderRadius: BorderRadius.circular(16)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: lightGrey, width: 1),
        borderRadius: BorderRadius.circular(16)),
    fillColor: fieldColor,
    filled: true,
    hintText: hint,
    hintStyle: const TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
  );
}

nameField(String hint) {
  return InputDecoration(
    border: InputBorder.none,
    
    focusColor: Colors.white,
    suffixIcon: const FaIcon(
      FontAwesomeIcons.penToSquare,
      color: grey,
      size: 35,
    ),
    enabledBorder: InputBorder.none,
    hintText: hint,
    
    hintStyle: const TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
  );
}
