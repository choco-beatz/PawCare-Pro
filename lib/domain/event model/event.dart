import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

part 'event.g.dart';

@HiveType(typeId: 7)
class Event {
  @HiveField(0)
  late String iname;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late int id;

  @HiveField(3)
  late int petId;

    @HiveField(4)
  late String date;


  Event(
      {required this.iname,
      required this.title,
      required this.id,
      required this.petId,
      required this.date});
}
