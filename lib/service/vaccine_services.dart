
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pawcare_pro/domain/vaccine%20model/vaccine.dart';

class VaccineService {
  Box<Vaccine>? _vaccineBox;

  //to insert the generated id into db

  //to create/open the box
  Future<void> openBox() async {
    _vaccineBox = await Hive.openBox<Vaccine>('VACCINEBOX');
  }

  //to close the box
  Future<void> closeBox() async {
    await _vaccineBox!.close();
  }

  //to add to box
  Future<void> addVaccine(Vaccine vaccine) async {
    if (_vaccineBox == null) {
      await openBox();
    }

    await _vaccineBox!.put(vaccine.id, vaccine);
  }

  //to get datas from the box
  Future<List<Vaccine>> getVaccines() async {
    if (_vaccineBox == null) {
      await openBox();
    }
    final list = <Vaccine>[];
    for (var i in _vaccineBox!.values) {
      list.add(i);
    }
  
    return _vaccineBox!.values.toList();
  }

  //to get data from the box
  Future<Vaccine?> getVaccine(int? id) async {
    if (_vaccineBox == null) {
      await openBox();
    }
    final vaccine = _vaccineBox!.get(id);
    return vaccine;
  }

  //to update datas in the box
  Future<void> updateVaccine(int? id, Vaccine vaccine) async {
    if (_vaccineBox == null) {
      await openBox();
    }
    if (id != null) {
      await _vaccineBox!.put(id, vaccine);
    } else {
      print(id);
    }
  }

  //to delete data in the box
  Future<void> deleteVaccine(int id) async {
    if (_vaccineBox == null) {
      await openBox();
    }
    await _vaccineBox!.delete(id);
  }
}
