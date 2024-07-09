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
import 'package:pawcare_pro/presentation/views/nutrition/widgets/image.dart';
import 'package:pawcare_pro/presentation/views/widgets/normalappbar.dart';
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
        appBar: normalAppBar('Edit Recipies'),
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
                    CircleImageRec(image: image),
                    Positioned(
                        left: 115,
                        top: 130,
                        child: Container(
                            decoration: imageButtonDecor(),
                            child: IconButton(
                                onPressed: () async {
                                  getMainImagesFromGallery();
                                },
                                icon: imageIconn())))
                  ])),
                  space,
                  space,
                  label('Recipe name'),
                  Fields(
                    controller: _nameController,
                    hint: "Enter the name of the recipe",
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
                          icon: addIcon())
                    ]
                  ),
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
                                    )
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
