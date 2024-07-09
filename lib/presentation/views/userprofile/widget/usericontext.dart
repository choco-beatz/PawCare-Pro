  import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

Icon userIcon1() {
    return const Icon(
                                              Icons.add,
                                              color: lightGrey,
                                              size: 40,
                                            );
  }

    Text userText1() {
    return const Text(
                                  'Add pet',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: lightGrey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                );
  }