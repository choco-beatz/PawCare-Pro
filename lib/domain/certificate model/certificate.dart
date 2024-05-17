import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';

part 'certificate.g.dart';

@HiveType(typeId: 2)
class Certificate {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String file;

  @HiveField(2)
  late String idate;

  @HiveField(3)
  late String edate;

  @HiveField(4)
  late List<PetInfo>? pet;

  @HiveField(5)
  late int id;

  Certificate(
      {required this.name,
      required this.file,
      required this.idate,
      required this.edate,
      required this.id,
      this.pet});
}
