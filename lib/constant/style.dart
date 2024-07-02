import 'package:flutter/material.dart';

heading(String data) {
  return Text(
    data,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
        color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
  );
}

heading3(String data) {
  return Center(
    child: Text(
      data,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
    ),
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
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
        color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
  );
}

subject2(String data) {
  return Text(
    data,
    style: const TextStyle(
      color: Color.fromARGB(255, 211, 211, 211),
      fontSize: 18,
    ),
  );
}

eventicon(String data) {
  return Text(
    data,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      color: Color.fromARGB(255, 211, 211, 211),
      fontSize: 16,
    ),
  );
}

dateButtonText(String data) {
  return Text(
    overflow: TextOverflow.ellipsis,
    data,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  );
}

leading(String data) {
  return Text(
    overflow: TextOverflow.ellipsis,
    data,
    style: const TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontSize: 18,
    ),
  );
}

const TextStyle name =
    TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500);
