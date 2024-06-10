import 'package:flutter/material.dart';

title(String name) {
  return Text(
    name,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.w700,
    ),
  );
}
