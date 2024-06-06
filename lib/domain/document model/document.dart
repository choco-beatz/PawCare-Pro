import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

part 'document.g.dart';

@HiveType(typeId: 5)
class Documents {
  @HiveField(0)
  late String dname;

  @HiveField(1)
  late String dfile;

  @HiveField(2)
  late String didate;

  @HiveField(3)
  late String dedate;

  @HiveField(4)
  late int petID;

  @HiveField(5)
  late int did;

  Documents(
      {required this.dname,
      required this.dfile,
      required this.didate,
      required this.dedate,
      required this.did,
      required this.petID});
}
