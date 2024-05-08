import 'package:flutter/material.dart';

heading(String data) {
  return Text(
    data,
    style: const TextStyle(
        color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
  );
}

subject(String data) {
  return Text(
    data,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  );
}

heading2(String data) {
  return Text(
    data,
    style: const TextStyle(
        color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
  );
}

subject2(String data) {
  return Text(
    data,
    style: const TextStyle(
      color: Color.fromARGB(255, 175, 175, 175),
      fontSize: 18,
    ),
  );
}
