import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/style.dart';

// ignore: must_be_immutable
class DrawerList extends StatelessWidget {
  IconData? icon;
  String? text;
  DrawerList({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: leading(text!),
    );
  }
}
