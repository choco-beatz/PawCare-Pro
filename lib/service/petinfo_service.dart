import 'package:hive_flutter/hive_flutter.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';

class PetInfoService {
  Box<PetInfo>? _petInfoBox;

  get petInfo => _petInfoBox;

  //to insert the generated id into db

  //to create/open the box
  Future<void> openBox() async {
    _petInfoBox = await Hive.openBox<PetInfo>('PETINFOBOX');
  }

  //to close the box
  Future<void> closeBox() async {
    await _petInfoBox!.close();
  }

  //to add to box
  Future<void> addPet(PetInfo pet) async {
    if (_petInfoBox == null) {
      await openBox();
    }

    await _petInfoBox!.put(pet.id, pet);
  }

  //to get datas from the box
  Future<List<PetInfo>> getPets() async {
    if (_petInfoBox == null) {
      await openBox();
    }
    final list = <PetInfo>[];
    for (var i in _petInfoBox!.values) {
      list.add(i);
    }
    return _petInfoBox!.values.toList();
  }

  //to get datas from the box
  Future<PetInfo?> getPet(int? id) async {
    if (_petInfoBox == null) {
      await openBox();
    }
    final pet = _petInfoBox!.get(id);
    return pet;
  }

  //to update datas in the box
  Future<void> updatePet(int? id, PetInfo pet) async {
    if (_petInfoBox == null) {
      await openBox();
    }
    if (id != null) {
      await _petInfoBox!.put(id, pet);
    } else {
      print(id);
    }
  }

  //to delete data in the box
  Future<void> deletePet(int id) async {
    if (_petInfoBox == null) {
      await openBox();
    }
    await _petInfoBox!.delete(id);
  }
}
