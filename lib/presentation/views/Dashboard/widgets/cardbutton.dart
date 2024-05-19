import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';

class CardButton extends StatelessWidget {
  String heading;
  String image;
  Color bg;
  CardButton(
      {super.key,
      required this.bg,
      required this.heading,
      required this.image});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        width: screenWidth * 0.45,
        height: screenHeight * 0.26,
        decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: lightGrey,
              width: 1,
            )),
        child: Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: lightGrey,
                  radius: 60,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(0, 255, 255, 255),
                    radius: 59,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: bg,
                    ),
                  ),
                ),
                space,
                subject(heading)
              ],
            ),
          ),
          Positioned(
              top: 60,
              left: 50,
              child: Image.asset(
                height: 75,
                width: 75,
                fit: BoxFit.cover,
                image,
              ))
        ]));
  }
}
