import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

part 'pet.g.dart';

@HiveType(typeId: 0)
class PetInfo {
  @HiveField(0)
  late String type;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String breed;

  @HiveField(3)
  late String description;

  @HiveField(4)
  late String gender;

  @HiveField(5)
  late String size;

  @HiveField(6)
  late String weight;

  @HiveField(7)
  late String image;

@HiveField(8)
  late String bday;

  @HiveField(9)
  late String aday;


  PetInfo(
      {required this.type,
      required this.name,
      required this.breed,
      required this.description,
      required this.gender,
      required this.size,
      required this.weight,
      required this.image,
      required this.bday,
      required this.aday,});
}
