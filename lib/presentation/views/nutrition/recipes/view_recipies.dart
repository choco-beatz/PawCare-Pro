import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/domain/recipe%20model/recipe.dart';
import 'package:pawcare_pro/presentation/views/nutrition/recipes/add_recipies.dart';
import 'package:pawcare_pro/presentation/views/nutrition/recipes/empty_recipies.dart';
import 'package:pawcare_pro/presentation/views/nutrition/recipes/view_rec.dart';
import 'package:pawcare_pro/presentation/views/nutrition/widgets/recipiecard.dart';
import 'package:pawcare_pro/service/recipe_service.dart';

class ViewRecipies extends StatefulWidget {
  final int petId;
  const ViewRecipies({super.key, required this.petId});

  @override
  State<ViewRecipies> createState() => _ViewRecipiesState();
}

class _ViewRecipiesState extends State<ViewRecipies> {
  final RecipeService _recipeService = RecipeService();

  List<Recipe> _recipe = [];
  List<Recipe> currentRecipe = [];

  Future<void> _loadRecipe() async {
    //the datas recived from the db is stored
    currentRecipe.clear();
    _recipe = await _recipeService.getRecipes();
    for (var rec in _recipe) {
      if (widget.petId == rec.petId) {
        currentRecipe.add(rec);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _loadRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainBG,
          foregroundColor: Colors.white,
          title: const Text(
            'Recipies',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  //the result(vaccine object) which is passed from the pop is recieved here
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => AddRecipies(
                                petId: widget.petId,
                              ))));

                  //to check if the returned result is not null and they type is Certificate
                  if (result != null && result is Recipe) {
                    //the result that is recieved is added to the List that is to be displayed
                    // _document.add(result);
                    await _loadRecipe();
                  }
                },
                icon: const Icon(
                  Icons.add,
                  size: 35,
                  color: mainColor,
                ))
          ],
        ),
        backgroundColor: mainBG,
        body: Padding(
          padding: const EdgeInsets.all(6),
          child: _recipe.isEmpty
              ? EmptyRecipies(
                  petId: widget.petId,
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  itemCount: currentRecipe.length,
                  itemBuilder: (context, index) {
                    final current = currentRecipe[index];
                    return Padding(
                      padding: const EdgeInsets.all(6),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ViewRec(
                                      petId: widget.petId,
                                      id: current.id,
                                      name: current.name,
                                      ingredients: current.ingredients,
                                      direction: current.direction,
                                      image: current.image))));
                        },
                        child: RecipieCard(
                            heading: current.name, image: current.image),
                      ),
                    );
                  }),
        ));
  }
}
