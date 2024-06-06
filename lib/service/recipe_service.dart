
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pawcare_pro/domain/recipe%20model/recipe.dart';


class RecipeService {
  Box<Recipe>? _recipeBox;

  //to insert the generated id into db

  //to create/open the box
  Future<void> openBox() async {
    _recipeBox = await Hive.openBox<Recipe>('RECIPEBOX');
  }

  //to close the box
  Future<void> closeBox() async {
    await _recipeBox!.close();
  }

  //to add to box
  Future<void> addRecipe(Recipe recipe) async {
    if (_recipeBox == null) {
      await openBox();
    }

    await _recipeBox!.put(recipe.id, recipe);
  }

  //to get datas from the box
  Future<List<Recipe>> getRecipes() async {
    if (_recipeBox == null) {
      await openBox();
    }
    final list = <Recipe>[];
    for (var i in _recipeBox!.values) {
      list.add(i);
    }
  
    return _recipeBox!.values.toList();
  }

  //to get data from the box
  Future<Recipe?> getRecipe(int? id) async {
    if (_recipeBox == null) {
      await openBox();
    }
    final recipe = _recipeBox!.get(id);
    return recipe;
  }

  //to update datas in the box
  Future<void> updateRecipe(int? id, Recipe recipe) async {
    if (_recipeBox == null) {
      await openBox();
    }
    if (id != null) {
      await _recipeBox!.put(id, recipe);
    } else {
      print(id);
    }
  }

  //to delete data in the box
  Future<void> deleteRecipe(int id) async {
    if (_recipeBox == null) {
      await openBox();
    }
    await _recipeBox!.delete(id);
  }
}
