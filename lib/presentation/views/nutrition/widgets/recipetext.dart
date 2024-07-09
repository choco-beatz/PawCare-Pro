import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

title(String name) {
  return Text(
    name,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      color: white,
      fontSize: 28,
      fontWeight: FontWeight.w700,
    ),
  );
}
