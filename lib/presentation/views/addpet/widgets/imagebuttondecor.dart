  import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

BoxDecoration imageButtonDecor() {
    return BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: white,
                          );
  }

   Icon imageIcon() {
    return const Icon(
                                size: 25,
                                Icons.image_outlined,
                                color: mainColor,
                              );
  }
