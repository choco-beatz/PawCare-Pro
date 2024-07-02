import 'dart:core';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:open_file/open_file.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/certificate%20model/certificates.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/service/certificate_service.dart';

class EditCertificates extends StatefulWidget {
  final int id;
  final int petId;
  const EditCertificates({super.key, required this.id, required this.petId});

  @override
  State<EditCertificates> createState() => _EditCertificatesState();
}

class _EditCertificatesState extends State<EditCertificates> {
  //TextEditingController
  final TextEditingController _certNameController = TextEditingController();

  //to access the db functions
  final CertificateService _certificateService = CertificateService();

  //for dates
  DateTime idate = DateTime.now();
  DateTime edate = DateTime.now();

  String formattedIDate = 'not set';
  String formattedEDate = 'not set';

  //for file
  String? filePath;

  PlatformFile? file;

  //for file picker
  FilePickerResult? result;

  Certificates? _cert;

  Future<void> _loadDoc() async {
    final certificate = await _certificateService.getCertificate(widget.id);
    if (certificate != null) {
      setState(() {
        _cert = certificate;
        _certNameController.text = _cert!.name;

        filePath = _cert!.file;
        formattedEDate = _cert!.edate;
        formattedIDate = _cert!.idate;
      });
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _loadDoc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final String? fileName = filePath != null ? path.basename(filePath!) : null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: Colors.white,
        title: const Text(
          'Edit Certificate',
          style: TextStyle(fontSize: 18),
        ),
      ),
      backgroundColor: mainBG,
      body: _cert == null
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBox,
                    Center(
                      child: Stack(children: [
                        CircleAvatar(
                            backgroundColor: grey,
                            radius: 95,
                            child: GestureDetector(
                              onTap: () async {
                                result = await FilePicker.platform
                                    .pickFiles(type: FileType.any);

                                if (result != null) {
                                  setState(() {
                                    filePath = result?.files.single.path;
                                    file = result!.files.single;
                                  });
                                }
                              },
                              child: CircleAvatar(
                                  backgroundColor: transGrey,
                                  radius: 80,
                                  child: (result == null && filePath == null)
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              size: 50,
                                              Icons.file_upload,
                                              color: Colors.white,
                                            ),
                                            sSpace,
                                            eventicon('Upload file here')
                                          ],
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            //to open file
                                            // final file = result!.files.first;
                                            openFile(file!);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                size: 50,
                                                Icons.file_open_outlined,
                                                color: Colors.white,
                                              ),
                                              sSpace,
                                              eventicon(fileName != null
                                                  ? path.basename(fileName)
                                                  : 'Unknown file'),
                                              eventicon('Tap to view the file')
                                            ],
                                          ),
                                        )),
                            )),
                        Positioned(
                          left: 125,
                          top: 140,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: IconButton(
                                onPressed: () async {
                                  result = await FilePicker.platform
                            .pickFiles(type: FileType.any);

                        if (result != null) {
                          setState(() {
                            filePath = result?.files.single.path;
                            file = result!.files.single;
                          });
                        }
                                },
                                icon: const Icon(
                                  size: 30,
                                  Icons.delete_outline_rounded,
                                  color: mainColor,
                                )),
                          ),
                        )
                      ]),
                    ),
                    space,
                    space,
                    label('Certificate name'),
                    SizedBox(
                      height: 52,
                      width: 370,
                      child: TextFormField(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        decoration:
                            fieldDecor("Enter the name of the Certificate"),
                        controller: _certNameController,
                      ),
                    ),
                    line,
                    space,
                    label('Important Dates'),
                    OutlinedButton(
                        onPressed: () {
                          setState(() {
                            showDatePicker(
                                    context: context,
                                    initialDate: idate,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now())
                                .then((value) {
                              setState(() {
                                idate = value!;
                                formattedIDate =
                                    DateFormat('dd-MMM-yyyy').format(idate);
                              });
                            });
                          });
                        },
                        style: dateButton,
                        child: formattedIDate == 'not set'
                            ? dateButtonText('Add Issued date')
                            : dateButtonText('Issued date: $formattedIDate')),
                    space,
                    OutlinedButton(
                        onPressed: () {
                          setState(() {
                            showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    initialDate: edate,
                                    lastDate: DateTime(3000))
                                .then((value) {
                              setState(() {
                                edate = value!;
                                formattedEDate =
                                    DateFormat('dd-MMM-yyyy').format(edate);
                              });
                            });
                          });
                        },
                        style: dateButton,
                        child: formattedEDate == 'not set'
                            ? dateButtonText('Add Expiry date')
                            : dateButtonText('Expiry date: $formattedEDate')),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    FilledButton(
                        onPressed: () async {
                          if (_certNameController.text.isEmpty ||
                              filePath!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please Enter the neccessary details!')));
                            return;
                          } else {
                            final certificate = Certificates(
                                name: _certNameController.text,
                                id: _cert!.id,
                                file: filePath ?? '',
                                idate: formattedIDate,
                                edate: formattedEDate,
                                petId: widget.petId);
                            await _certificateService
                                .updateCertificate(certificate.id, certificate)
                                .then((_) {
                              _certNameController.clear();
                              setState(() {});
                              Navigator.pop(context, certificate);
                            });
                          }
                        },
                        style: mainButton,
                        child: const Text('Save'))
                  ],
                ),
              ),
            ),
    );
  }

  //function to open the file
  void openFile(PlatformFile file) {
    OpenFile.open(filePath);
  }
}
