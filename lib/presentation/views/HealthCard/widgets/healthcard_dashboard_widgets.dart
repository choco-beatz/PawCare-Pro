import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/style.dart';
class HealthCardButton extends StatelessWidget {
  Color bgColor;
  Color brColor;
  String head;
  String image;
  HealthCardButton({super.key, required this.bgColor, required this.brColor, required this.head, required this.image });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: fieldColor,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: bgColor,
                  border: Border.all(color: brColor, width: 0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(image),
              ),
            ),
          ),
          subject(head)
        ],
      ));
  }
}

