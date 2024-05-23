import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/style.dart';

list(IconData icon, String text)
{
  return ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: leading(text),
        );
}