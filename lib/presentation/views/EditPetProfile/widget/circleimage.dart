import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    required this.image,
  });

  final String? image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: lightGrey,
        radius: 90,
        child: CircleAvatar(
          backgroundImage: FileImage(File(image!)),
          radius: 70,
        ));
  }
}
