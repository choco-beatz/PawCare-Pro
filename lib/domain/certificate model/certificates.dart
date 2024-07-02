import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

part 'certificates.g.dart';

@HiveType(typeId: 2)
class Certificates {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String file;

  @HiveField(2)
  late String idate;

  @HiveField(3)
  late String edate;

  @HiveField(4)
  late int petId;

  @HiveField(5)
  late int id;

  Certificates(
      {required this.name,
      required this.file,
      required this.idate,
      required this.edate,
      required this.id,
      required this.petId});
}
