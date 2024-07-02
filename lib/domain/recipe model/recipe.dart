import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

part 'recipe.g.dart';

@HiveType(typeId: 6)
class Recipe {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late List<String> ingredients;

  @HiveField(2)
  late String direction;

  @HiveField(3)
  late String image;

 @HiveField(4)
  late int id;

  @HiveField(5)
  late int petId;

  Recipe(
      {required this.name,
      required this.ingredients,
      required this.direction,
      required this.id,
      required this.image,
      required this.petId});
}
