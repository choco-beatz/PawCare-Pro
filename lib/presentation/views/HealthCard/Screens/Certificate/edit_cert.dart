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
import 'package:pawcare_pro/domain/certificate%20model/certificates.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/imagebuttondecor.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/documents/widget/date.dart';
import 'package:pawcare_pro/presentation/views/documents/widget/fileupload.dart';
import 'package:pawcare_pro/presentation/views/documents/widget/icons.dart';
import 'package:pawcare_pro/presentation/views/widgets/normalappbar.dart';
import 'package:pawcare_pro/service/certificate_service.dart';

class EditCertificates extends StatefulWidget {
  final int id,petId;
  const EditCertificates({super.key, required this.id, required this.petId});

  @override
  State<EditCertificates> createState() => _EditCertificatesState();
}

class _EditCertificatesState extends State<EditCertificates> {
  final TextEditingController _certNameController = TextEditingController();
  final CertificateService _certificateService = CertificateService();
  DateTime idate = DateTime.now(),edate = DateTime.now();
  String formattedIDate = 'not set',formattedEDate = 'not set';
  String? filePath;
  PlatformFile? file;
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
    }if (mounted) {
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
    final String? fileName = filePath != null ? path.basename(filePath!) : null;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: normalAppBar('Edit Certificate'),
        backgroundColor: mainBG,
        body: _cert == null
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(20),
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
                                    ? fileUpload('Upload file here')
                                    : GestureDetector(
                                        onTap: () {
                                          openFile(file!);
                                        },
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              fileUploadIcon(),
                                              sSpace,
                                              eventicon(fileName != null
                                                  ? path.basename(fileName)
                                                  : 'Unknown file'),
                                              eventicon(
                                                  'Tap to view the file')
                                            ]))))),
                    Positioned(
                        left: 125,
                        top: 140,
                        child: Container(
                            decoration: imageButtonDecor(),
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
                                icon: delete())))
                  ])),
                  space,
                  space,
                  label('Certificate name'),
                  Fields(
                      hint: "Enter the name of the Certificate",
                      controller: _certNameController),
                  line,
                  space,
                  label('Important Dates'),
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          showIDate(context, idate).then((value) {
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
                          showEDate(context, edate).then((value) {
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
                  Spacer(),
                  FilledButton(
                      onPressed: () async {
                        if (_certNameController.text.isEmpty ||
                            filePath!.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar());
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
                              .updateCertificate(
                                  certificate.id, certificate)
                              .then((_) {
                            setState(() {});
                            Navigator.pop(context, certificate);
                          });
                        }
                      },
                      style: mainButton,
                      child: const Text('Save'))
                ])));
  }

  void openFile(PlatformFile file) {
    OpenFile.open(filePath);
  }
}
