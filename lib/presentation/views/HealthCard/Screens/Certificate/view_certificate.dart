import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/certificate%20model/certificates.dart';
import 'package:pawcare_pro/presentation/views/documents/widget/alert.dart';
import 'package:pawcare_pro/presentation/views/documents/widget/icons.dart';
import 'package:pawcare_pro/presentation/views/healthcard/Screens/Certificate/add_certificates.dart';
import 'package:pawcare_pro/presentation/views/healthcard/screens/certificate/edit_cert.dart';
import 'package:pawcare_pro/presentation/views/healthcard/screens/certificate/emptycertificate.dart';
import 'package:pawcare_pro/presentation/views/healthcard/screens/certificate/view_cert.dart';
import 'package:pawcare_pro/service/certificate_service.dart';

class ViewCertificates extends StatefulWidget {
  final int petId;
  const ViewCertificates({super.key, required this.petId});

  @override
  State<ViewCertificates> createState() => _ViewCertificatesState();
}

class _ViewCertificatesState extends State<ViewCertificates> {
  final CertificateService _certificateService = CertificateService();

  //we get all the datas in the db as list of type model
  List<Certificates> _certificate = [];
  List<Certificates> currentCertificate = [];

  //loading/fetching data from the hive
  Future<void> _loadCertificates() async {
    //the datas recived from the db is stored
    currentCertificate.clear();
    _certificate = await _certificateService.getCertificates();
    for (var cert in _certificate) {
      if (widget.petId == cert.petId) {
        currentCertificate.add(cert);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _loadCertificates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: mainBG,
          foregroundColor: white,
          title: const Text(
            'Certificates',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  //the result(certificate object) which is passed from the pop is recieved here
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => AddCertificates(
                                petId: widget.petId,
                              ))));

                  //to check if the returned result is not null and they type is Certificate
                  if (result != null && result is Certificates) {
                    setState(() async {
                      //the result that is recieved is added to the List that is to be displayed
                      await _loadCertificates();
                    });
                  }
                },
                icon: add())
          ],
        ),
        backgroundColor: mainBG,
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: currentCertificate.isEmpty
                ? EmptyCert(
                    petId: widget.petId,
                  )
                : ListView.builder(
                    itemCount: currentCertificate.length,
                    itemBuilder: (context, index) {
                      final current = currentCertificate[index];
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Card(
                              color: grey,
                              child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => ViewCert(
                                                edate: current.edate,
                                                idate: current.idate,
                                                name: current.name,
                                                file: current.file))));
                                  },
                                  trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              final updatedCertInfo =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditCertificates(
                                                    id: current.id,
                                                    petId: current.petId,
                                                  ),
                                                ),
                                              );

                                              if (updatedCertInfo != null &&
                                                  updatedCertInfo
                                                      is Certificates) {
                                                setState(() {
                                                  currentCertificate[index] =
                                                      updatedCertInfo;
                                                });
                                              }
                                            },
                                            icon: edit()),
                                        IconButton(
                                            onPressed: () => showDialog<void>(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    AlertDialog(
                                                        backgroundColor: mainBG,
                                                        title: aleartText(
                                                            'Delete?'),
                                                        content: aleartText(
                                                            'Are you sure?'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                              style:
                                                                  cancelButton,
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: aleartText(
                                                                  'Cancel')),
                                                          TextButton(
                                                              style: delButton,
                                                              onPressed:
                                                                  () async {
                                                                await _certificateService
                                                                    .deleteCertificate(
                                                                        current
                                                                            .id);

                                                                setState(() {
                                                                  _certificate
                                                                      .removeAt(
                                                                          index);
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: aleartText(
                                                                  'OK'))
                                                        ])),
                                            icon: const Icon(
                                              Icons.delete_outline_rounded,
                                              size: 35,
                                              color: offwhite,
                                            ))
                                      ]),
                                  title: leading(current.name),
                                  subtitle: Row(children: [
                                    const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: offwhite,
                                          size: 18,
                                        )),
                                    subject2(current.idate)
                                  ]))));
                    })));
  }
}
