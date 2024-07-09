import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

class PositionedIcon extends StatelessWidget {
  const PositionedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
                    backgroundColor: mainBG,
                    radius: 40,
                    child: CircleAvatar(
                      backgroundColor: mainColor,
                      radius: 30,
                      child: CircleAvatar(
                        backgroundColor: mainBG,
                        foregroundColor: mainColor,
                        radius: 28,
                        child: Icon(
                          Icons.edit,
                          size: 30,
                        ),
                      ),
                    ),
                  );
  }
}