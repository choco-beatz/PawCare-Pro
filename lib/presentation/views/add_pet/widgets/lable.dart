import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';

label(String data) {
  return Column(
    children: [
      Text(
        data,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      space
    ],
  );
}
