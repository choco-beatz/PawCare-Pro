import 'package:hive_flutter/hive_flutter.dart';
import 'package:pawcare_pro/domain/model/pet.dart';

class PetInfoService {
  Box<PetInfo>? _petInfoBox;

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
    await _petInfoBox!.add(pet);
  }

  //to get datas from the box
  Future<List<PetInfo>> getPet() async {
    if (_petInfoBox == null) {
      await openBox();
    }
    return _petInfoBox!.values.toList();
  }

  //to update datas in the box
  Future<void> updatePet(int index, PetInfo pet) async {
    if (_petInfoBox == null) {
      await openBox();
    }

    await _petInfoBox!.putAt(index, pet);
  }

  //to delete data in the box
  Future<void>deletePet(int index) async{
     if (_petInfoBox == null) {
      await openBox();
    }
    await _petInfoBox!.deleteAt(index);
  }
}
