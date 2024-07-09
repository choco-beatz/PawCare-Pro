import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

class CircleImageRec extends StatelessWidget {
  const CircleImageRec({
    super.key,
    required this.image,
  });

  final String? image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: grey,
      radius: 95,
      child: image != null
          ? CircleAvatar(
              backgroundImage: FileImage(File(image ?? '')),
              radius: 80,
            )
          : const CircleAvatar(
              radius: 80,
              backgroundColor: lightGrey,
              child: Icon(
                size: 65,
                Icons.camera_alt_outlined,
                color: white,
              ),
            ),
    );
  }
}
