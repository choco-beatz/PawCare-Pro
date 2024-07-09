import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

Icon delete() {
  return const Icon(
    size: 30,
    Icons.delete_outline_rounded,
    color: offwhite,
  );
}

Icon fileUploadIcon() {
  return const Icon(
    size: 50,
    Icons.file_open_outlined,
    color: white,
  );
}

Icon add() {
  return const Icon(
    Icons.add,
    size: 35,
    color: mainColor,
  );
}

Icon edit() {
  return const Icon(
    Icons.mode_edit_outline_outlined,
    size: 35,
    color: offwhite,
  );
}
