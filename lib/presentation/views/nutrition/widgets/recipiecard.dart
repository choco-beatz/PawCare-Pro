import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';

class RecipieCard extends StatelessWidget {
  String heading;
  String image;

  RecipieCard({super.key, required this.heading, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(31, 122, 125, 127),
                  radius: 80,
                  child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(31, 122, 125, 127),
                      radius: 64,
                      child: image.isNotEmpty
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(File(image)),
                            )
                          : const CircleAvatar(
                              radius: 50,
                              backgroundColor: transparent3,
                              child: Icon(
                                size: 60,
                                Icons.cookie_outlined,
                                color: white,
                              ))),
                ),
              ),
              space,
              leading(heading),
            ],
          ),
        ),
      ),
    );
  }
}
