import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/nutrition/recipes/edit_rec.dart';
import 'package:pawcare_pro/presentation/views/nutrition/widgets/recipetext.dart';
import 'package:pawcare_pro/service/recipe_service.dart';

class ViewRec extends StatelessWidget {
  final int id;
  final int petId;
  final String name;
  final List<String> ingredients;
  final String direction;
  final String image;
  ViewRec(
      {super.key,
      required this.name,
      required this.id,
      required this.ingredients,
      required this.direction,
      required this.image,
      required this.petId});

  final RecipeService _recipeService = RecipeService();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                  for (int i = 0; i < ingredients.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: subject2('${i + 1}. ${ingredients[i]}'),
                    ),
                  sizedBox,
                  line,
                  sizedBox,
                  label('Directions'),
                  subject2(direction),
                  SizedBox(
                    height: height * 0.18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.45,
                        height: height * 0.06,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditRecipies(petId: petId, id: id)));
                          },
                          style: cancelButton,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.penToSquare,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                ' Edit',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.45,
                        height: height * 0.06,
                        child: FilledButton(
                          onPressed: () => showDialog<void>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    backgroundColor: mainBG,
                                    title: const Text(
                                      'Delete?',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: const Text(
                                      'Are you sure?',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: cancelButton,
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      TextButton(
                                        style: delButton,
                                        onPressed: () async {
                                          await _recipeService.deleteRecipe(id);

                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )),
                          style: delButton,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.white,
                                size: 25,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
