import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/certificate%20model/certificates.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/documents/widget/date.dart';
import 'package:pawcare_pro/presentation/views/widgets/normalappbar.dart';
import 'package:pawcare_pro/service/certificate_service.dart';

class AddCertificates extends StatefulWidget {
  final int petId;
  const AddCertificates({super.key, required this.petId});

  @override
  State<AddCertificates> createState() => _AddCertificatesState();
}

class _AddCertificatesState extends State<AddCertificates> {
  //TextEditingControllers
  final TextEditingController _fileNameController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: normalAppBar('Certificates'),
        backgroundColor: mainBG,
        body: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              sizedBox,
              Center(
                  child: CircleAvatar(
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
                              child: result == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          size: 50,
                                          Icons.file_upload,
                                          color: white,
                                        ),
                                        sSpace,
                                        eventicon('Upload file here')
                                      ],
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        final file = result!.files.first;
                                        openFile(file);
                                      },
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              size: 50,
                                              Icons.file_open_outlined,
                                              color: white,
                                            ),
                                            sSpace,
                                            eventicon(file!.name),
                                            eventicon('Tap to view the file')
                                          ])))))),
              space,
              space,
              label('Certificate name'),
              SizedBox(
                height: 52,
                width: 370,
                child: TextFormField(
                  style: const TextStyle(color: white, fontSize: 20),
                  decoration: fieldDecor(" Enter the name of the Certificate"),
                  controller: _fileNameController,
                ),
              ),
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
                              DateFormat('dd-MM-yyyy').format(idate);
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
                              DateFormat('dd-MM-yyyy').format(edate);
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
                    if (_fileNameController.text.isEmpty ||
                        filePath == null ||
                        filePath!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('Please Enter the neccessary details!')));
                      return;
                    } else {
                      final certificate = Certificates(
                          name: _fileNameController.text,
                          id: DateTime.now().microsecond,
                          file: filePath ?? '',
                          idate: formattedIDate,
                          edate: formattedEDate,
                          petId: widget.petId);

                      await _certificateService
                          .updateCertificate(certificate.id, certificate)
                          .then((_) {
                        Navigator.pop(context, certificate);
                      });
                    }
                  },
                  style: mainButton,
                  child: const Text('Save'))
            ])));
  }

  //function to open the file
  void openFile(PlatformFile file) {
    OpenFile.open(filePath);
  }
}
