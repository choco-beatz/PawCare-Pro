import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/recipe%20model/recipe.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/service/recipe_service.dart';

class AddRecipies extends StatefulWidget {
  final int petId;
  const AddRecipies({super.key, required this.petId});

  @override
  State<AddRecipies> createState() => _AddRecipiesState();
}

class _AddRecipiesState extends State<AddRecipies> {
  //TextEditingController
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _directionController = TextEditingController();

  String? image;

  //for getting the db functions
  final RecipeService _recipeService = RecipeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainBG,
          foregroundColor: Colors.white,
          title: const Text(
            'Add Recipies',
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: mainBG,
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  sizedBox,
                  Center(
                    child: Stack(clipBehavior: Clip.none, children: [
                      CircleAvatar(
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
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      Positioned(
                        left: 115,
                        top: 130,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: IconButton(
                              onPressed: () async {
                                getMainImagesFromGallery();
                              },
                              icon: const Icon(
                                size: 25,
                                Icons.image_outlined,
                                color: mainColor,
                              )),
                        ),
                      )
                    ]),
                  ),
                  space,
                  space,
                  label('Recipe name'),
                  SizedBox(
                    height: 52,
                    width: 370,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      decoration: fieldDecor("Enter the name of the recipe"),
                      controller: _nameController,
                    ),
                  ),
                  line,
                  space,
                  label('Ingredients'),
                  SizedBox(
                    // height: 52,
                    width: 370,
                    child: TextFormField(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        maxLines: 4,
                        decoration: fieldDecor(" Enter the ingredients"),
                        controller: _ingredientsController),
                  ),
                  line,
                  space,
                  label('Directions'),
                  SizedBox(
                    // height: 52,
                    width: 370,
                    child: TextFormField(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        maxLines: 5,
                        decoration: fieldDecor(" Enter the directions"),
                        controller: _directionController),
                  ),
                  space,
                  space,
                  FilledButton(
                      style: mainButton,
                      child: const Text('Done'),
                      onPressed: () async {
                        final recipe = Recipe(
                          name: _nameController.text,
                          ingredients: _ingredientsController.text,
                          direction: _directionController.text,
                          id: DateTime.now().microsecond,
                          image: image ?? '',
                          petId: widget.petId
                        );

                        await _recipeService
                            .updateRecipe(recipe.id, recipe)
                            .then(
                          (_) {
                            Navigator.pop(context, recipe);
                          },
                        );
                      })
                ]))));
  }

  Future getMainImagesFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000);
    XFile xfilePick = pickedFile!;

    setState(() {
      image = xfilePick.path;
    });
  }
}
