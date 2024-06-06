import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/style.dart';

class CardButton extends StatelessWidget {
  Color bgColor;
  Color brColor;
  String head;
  String image;
  CardButton(
      {super.key,
      required this.bgColor,
      required this.brColor,
      required this.head,
      required this.image});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: height * 0.115,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: fieldColor,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: height * 0.08,
                width: width * 0.16,
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
