import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/nutrition/widgets/recipetext.dart';

class ViewRec extends StatelessWidget {
  final String name;
  final String ingredients;
  final String direction;
  final String image;
  const ViewRec(
      {super.key,
      required this.name,
      required this.ingredients,
      required this.direction,
      required this.image});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text(
          'Recipies',
          style: TextStyle(fontSize: 18),
        ),
      ),
      backgroundColor: mainBG,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.6,
                  child: Container(
                    height: height * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(image)), fit: BoxFit.cover)),
                  ),
                ),
                Positioned(bottom: 10, left: 12, child: title(name))
              ],
            ),
            sizedBox,
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label('Ingredients'),
                  subject2(ingredients),
                  sizedBox,
                  line,
                  sizedBox,
                  label('Directions'),
                  subject2(direction)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
