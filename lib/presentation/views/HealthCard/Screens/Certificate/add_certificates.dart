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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    final file = result!.files.first;
                                    openFile(file);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        size: 50,
                                        Icons.file_open_outlined,
                                        color: Colors.white,
                                      ),
                                      sSpace,
                                      eventicon(file!.name),
                                      eventicon('Tap to view the file')
                                    ],
                                  ),
                                )),
                    )),
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
                              lastDate: DateTime.now())
                          .then((value) {
                        setState(() {
                          idate = value!;
                          formattedIDate =
                              DateFormat('dd-MM-yyyy').format(idate);
                        });
                      });
                    });
                    // _showDatePicker;
                    // formattedDate = DateFormat('dd-MM-yyyy').format(date);
                  },
                  style: dateButton,
                  child: formattedIDate == 'not set'
                      ? dateButtonText('Add Issued date')
                      : dateButtonText('Issued date: $formattedIDate')),
              space,
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      //  DateTime selDate = await _showDatePicker;
                      showDatePicker(
                              // barrierColor: mainBG,
                              context: context,
                              initialDate: edate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(3000))
                          .then((value) {
                        setState(() {
                          edate = value!;

                          formattedEDate =
                              DateFormat('dd-MM-yyyy').format(edate);
                        });
                      });
                    });
                    // _showDatePicker;
                    // formattedDate = DateFormat('dd-MM-yyyy').format(date);
                  },
                  style: dateButton,
                  child: formattedEDate == 'not set'
                      ? dateButtonText('Add Expiry date')
                      : dateButtonText('Expiry date: $formattedEDate')),
              const SizedBox(
                height: 90,
              ),
              FilledButton(
                  onPressed: () async {
                    if (_fileNameController.text.isEmpty ||
                        filePath!.isEmpty ||
                        filePath == null) {
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
                        _fileNameController.clear();

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Dashboard(petID: pet.id,)));

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
