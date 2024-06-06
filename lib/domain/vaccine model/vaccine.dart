import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

part 'vaccine.g.dart';

@HiveType(typeId: 3)
class Vaccine {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String idate;

  @HiveField(2)
  late String edate;

  @HiveField(3)
  late int petId;

  @HiveField(4)
  late int id;

  Vaccine(
      {required this.name,
      required this.idate,
      required this.edate,
      required this.id,
      required this.petId});
}
