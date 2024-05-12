import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class UserInfo {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String image;

  @HiveField(2)
  late List<PetInfo>? pets;

  UserInfo({
    required this.username,
    required this.image,
    this.pets
  });
}
