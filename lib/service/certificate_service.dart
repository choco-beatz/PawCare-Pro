import 'package:hive_flutter/hive_flutter.dart';
import 'package:pawcare_pro/domain/certificate%20model/certificates.dart';

class CertificateService {
  Box<Certificates>? _certificateBox;

  //to insert the generated id into db

  //to create/open the box
  Future<void> openBox() async {
    _certificateBox = await Hive.openBox<Certificates>('CERTIFICATEBOX');
  }

  //to close the box
  Future<void> closeBox() async {
    await _certificateBox!.close();
  }

  //to add to box
  Future<void> addCertificate(Certificates certificate) async {
    if (_certificateBox == null) {
      await openBox();
    }

    await _certificateBox!.put(certificate.id, certificate);
  }

  //to get datas from the box
  Future<List<Certificates>> getCertificates() async {
    if (_certificateBox == null) {
      await openBox();
    }
    final list = <Certificates>[];
    for (var i in _certificateBox!.values) {
      list.add(i);
    }

    return _certificateBox!.values.toList();
  }

  //to get data from the box
  Future<Certificates?> getCertificate(int? id) async {
    if (_certificateBox == null) {
      await openBox();
    }
    final certificate = _certificateBox!.get(id);
    return certificate;
  }

  //to update datas in the box
  Future<void> updateCertificate(int? id, Certificates certificate) async {
    if (_certificateBox == null) {
      await openBox();
    }
    if (id != null) {
      await _certificateBox!.put(id, certificate);
    } else {
    }
  }

  //to delete data in the box
  Future<void> deleteCertificate(int id) async {
    if (_certificateBox == null) {
      await openBox();
    }
    await _certificateBox!.delete(id);
  }
}
