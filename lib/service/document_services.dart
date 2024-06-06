
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pawcare_pro/domain/document%20model/document.dart';

class DocumentService {
  Box<Documents>? _documentBox;

  //to insert the generated id into db

  //to create/open the box
  Future<void> openBox() async {
    _documentBox = await Hive.openBox<Documents>('DOCUMENTBOX');
  }

  //to close the box
  Future<void> closeBox() async {
    await _documentBox!.close();
  }

  //to add to box
  Future<void> adddocument(Documents document) async {
    if (_documentBox == null) {
      await openBox();
    }

    await _documentBox!.put(document.did, document);
  }

  //to get datas from the box
  Future<List<Documents>> getdocuments() async {
    if (_documentBox == null) {
      await openBox();
    }
    final list = <Documents>[];
    for (var i in _documentBox!.values) {
      list.add(i);
    }
  
    return _documentBox!.values.toList();
  }

  //to get data from the box
  Future<Documents?> getdocument(int? id) async {
    if (_documentBox == null) {
      await openBox();
    }
    final document = _documentBox!.get(id);
    return document;
  }

  //to update datas in the box
  Future<void> updatedocument(int? id, Documents document) async {
    if (_documentBox == null) {
      await openBox();
    }
    if (id != null) {
      await _documentBox!.put(id, document);
    } else {
      print(id);
    }
  }

  //to delete data in the box
  Future<void> deletedocument(int id) async {
    if (_documentBox == null) {
      await openBox();
    }
    await _documentBox!.delete(id);
  }
}
