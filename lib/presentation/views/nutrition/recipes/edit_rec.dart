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

class EditRecipies extends StatefulWidget {
  final int petId;
  final int id;
  const EditRecipies({super.key, required this.petId, required this.id});

  @override
  State<EditRecipies> createState() => _EditRecipiesState();
}

class _EditRecipiesState extends State<EditRecipies> {
  //TextEditingController
  final TextEditingController _nameController = TextEditingController();
  List<TextEditingController> ingredientsController = [TextEditingController()];
  final TextEditingController _directionController = TextEditingController();

  String? image;

  //for getting the db functions
  final RecipeService _recipeService = RecipeService();

  Recipe? _recipe;

  //loading/fetching data from the hive
  Future<void> _loadRecipe() async {
    //the datas recived from the db is stored into list
    _recipe = await _recipeService.getRecipe(widget.id);
    setState(() {
      _nameController.text = _recipe!.name;
      _directionController.text = _recipe!.direction;
      ingredientsController = _recipe!.ingredients
          .map((ingredient) => TextEditingController(text: ingredient))
          .toList();
      image = _recipe!.image;
    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _loadRecipe();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainBG,
          foregroundColor: Colors.white,
          title: const Text(
            'Edit Recipies',
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
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      decoration: fieldDecor("Enter the name of the recipe"),
                      controller: _nameController,
                    ),
                  ),
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
                          icon: const Icon(
                            size: 25,
                            Icons.add,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: ingredientsController.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 52,
                              width: width * 0.8,
                              child: TextFormField(
                                cursorColor: Colors.white,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                decoration: fieldDecor("Enter the ingredient"),
                                controller: ingredientsController[index],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  ingredientsController[index].clear();
                                  ingredientsController[index].dispose();
                                  ingredientsController.removeAt(index);
                                });
                              },
                              child: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.white,
                                size: 35,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  line,
                  space,
                  label('Directions'),
                  SizedBox(
                    width: 370,
                    child: TextFormField(
                        cursorColor: Colors.white,
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
                        List<String> ingredients = ingredientsController
                            .map((controller) => controller.text)
                            .toList();
                        final recipe = Recipe(
                            name: _nameController.text,
                            ingredients: ingredients,
                            direction: _directionController.text,
                            id: widget.id,
                            image: image ?? '',
                            petId: widget.petId);

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
