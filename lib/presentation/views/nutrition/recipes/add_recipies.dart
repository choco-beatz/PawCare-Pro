import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/recipe%20model/recipe.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/imagebuttondecor.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/nutrition/widgets/icons.dart';
import 'package:pawcare_pro/presentation/views/widgets/normalappbar.dart';
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
  List<TextEditingController> ingredientsController = [TextEditingController()];
  final TextEditingController _directionController = TextEditingController();

  String? image;

  //for getting the db functions
  final RecipeService _recipeService = RecipeService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: normalAppBar('Add Recipies'),
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
                                  color: white,
                                ))),
                    Positioned(
                        left: 115,
                        top: 130,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: white,
                            ),
                            child: IconButton(
                                onPressed: () async {
                                  getMainImagesFromGallery();
                                },
                                icon: imageIcon())))
                  ])),
                  space,
                  space,
                  label('Recipe name'),
                  Fields(
                      hint: "Enter the name of the recipe",
                      controller: _nameController),
                  space,
                  line,
                  space,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        label('Ingredients'),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                ingredientsController
                                    .add(TextEditingController());
                              });
                            },
                            icon: addIcon())
                      ]),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: ingredientsController.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 52,
                                    width: width * 0.8,
                                    child: TextFormField(
                                      cursorColor: white,
                                      style: const TextStyle(
                                          color: white, fontSize: 20),
                                      decoration:
                                          fieldDecor("Enter the ingredient"),
                                      controller: ingredientsController[index],
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ingredientsController[index].clear();
                                          ingredientsController[index]
                                              .dispose();
                                          ingredientsController.removeAt(index);
                                        });
                                      },
                                      child: deleteIcon())
                                ]));
                      }),
                  line,
                  space,
                  label('Directions'),
                  SizedBox(
                      width: 370,
                      child: TextFormField(
                          cursorColor: white,
                          style: const TextStyle(color: white, fontSize: 20),
                          maxLines: 5,
                          decoration: fieldDecor(" Enter the directions"),
                          controller: _directionController)),
                  space,
                  space,
                  FilledButton(
                      style: mainButton,
                      child: const Text('Done'),
                      onPressed: () async {
                        List<String> ingredients = ingredientsController
                            .map((controller) => controller.text)
                            .toList();
                        if (_nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please Enter the neccessary details!')));
                          return;
                        } else {
                          final recipe = Recipe(
                              name: _nameController.text,
                              ingredients: ingredients,
                              direction: _directionController.text,
                              id: DateTime.now().microsecond,
                              image: image ?? '',
                              petId: widget.petId);

                          await _recipeService
                              .updateRecipe(recipe.id, recipe)
                              .then(
                            (_) {
                              setState(() {});
                              Navigator.pop(context, recipe);
                            },
                          );
                        }
                      })
                ]))));
  }

  Future<void> getMainImagesFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000);

    if (pickedFile != null) {
      setState(() {
        image = pickedFile.path;
      });
    }
  }
}
