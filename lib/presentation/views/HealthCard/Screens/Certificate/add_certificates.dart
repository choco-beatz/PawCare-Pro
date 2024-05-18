import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/certificate%20model/certificate.dart';
import 'package:pawcare_pro/presentation/views/add_pet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/add_pet/widgets/lable.dart';
import 'package:pawcare_pro/service/certificate_services.dart';

class AddCertificates extends StatefulWidget {
  const AddCertificates({super.key});

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

  String? formattedIDate;
  String? formattedEDate;

  //for file
  String? filePath;

  //for file picker
  FilePickerResult? result = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: Colors.white,
        title: const Text(
          'Certificates',
          style: TextStyle(fontSize: 18),
        ),
      ),
      backgroundColor: mainBG,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBox,
            Center(
              child: Stack(clipBehavior: Clip.none, children: [
                CircleAvatar(
                  backgroundColor: grey,
                  radius: 95,
                  child: result == null
                      ? const CircleAvatar(
                          backgroundColor: lightGrey,
                          radius: 80,
                          child: Icon(
                            size: 65,
                            Icons.file_upload,
                            color: Colors.white,
                          ),
                        )
                      : const CircleAvatar(
                          radius: 80,
                          backgroundColor: lightGrey,
                          child: Icon(
                            size: 65,
                            Icons.file_copy_outlined,
                            color: Colors.white,
                          ),
                        ),
                ),
                Positioned(
                  left: 115,
                  top: 130,
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
                            });
                          }
                        },
                        icon: const Icon(
                          size: 25,
                          Icons.file_open_outlined,
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
                style: const TextStyle(color: Colors.white, fontSize: 20),
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
                    //  DateTime selDate = await _showDatePicker;
                    showDatePicker(
                            // barrierColor: mainBG,
                            context: context,
                            initialDate: idate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025))
                        .then((value) {
                      setState(() {
                        idate = value!;
                      });
                    });
                    formattedIDate = DateFormat('dd-MM-yyyy').format(idate);
                    print(formattedIDate);
                  });
                  // _showDatePicker;
                  // formattedDate = DateFormat('dd-MM-yyyy').format(date);
                },
                style: dateButton,
                child: dateButtonText('Add Issued date')),
            space,
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    //  DateTime selDate = await _showDatePicker;
                    showDatePicker(
                            // barrierColor: mainBG,
                            context: context,
                            initialDate: edate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025))
                        .then((value) {
                      setState(() {
                        edate = value!;
                      });
                    });
                    formattedEDate = DateFormat('dd-MM-yyyy').format(edate);
                  });
                  // _showDatePicker;
                  // formattedDate = DateFormat('dd-MM-yyyy').format(date);
                },
                style: dateButton,
                child: subject('Add Expiry date')),
            SizedBox(
              height: 90,
            ),
            FilledButton(
                onPressed: () async {
                  final certificate = Certificate(
                    name: _fileNameController.text,
                    id: DateTime.now().microsecond,
                    file: filePath ?? '',
                    idate: formattedIDate ?? '',
                    edate: formattedEDate ?? '',
                  );
                  print(certificate.name);
                  await _certificateService
                      .updateCertificate(certificate.id, certificate)
                      .then((_) {
                    _fileNameController.clear();
                    
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Dashboard(petID: pet.id,)));

                    Navigator.pop(context,certificate);
                  });
                },
                style: mainButton,
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }
}
