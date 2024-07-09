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
    return Center(
      child: CircleAvatar(
        backgroundColor: grey,
        radius: 150,
        child: CircleAvatar(
          backgroundColor: mainBG,
          radius: 149,
          child: CircleAvatar(
            backgroundColor: grey,
            radius: 120,
            child: CircleAvatar(
              backgroundColor: mainBG,
              radius: 119,
              child: image != null
                  ? CircleAvatar(
                      backgroundImage: FileImage(File(image ?? '')),
                      radius: 90,
                    )
                  : const CircleAvatar(
                      radius: 90,
                      backgroundColor: lightGrey,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: white,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
