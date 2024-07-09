import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';

Column fileUpload(String hint) {
    return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            size: 50,
                                            Icons.file_upload,
                                            color: white,
                                          ),
                                          sSpace,
                                          eventicon(hint)
                                        ],
                                      );
  }
