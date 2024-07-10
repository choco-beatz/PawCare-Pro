import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/document%20model/document.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/documents/widget/fileupload.dart';
import 'package:pawcare_pro/presentation/views/widgets/normalappbar.dart';
import 'package:pawcare_pro/service/document_services.dart';

class AddDocuments extends StatefulWidget {
  final int petId;
  const AddDocuments({super.key, required this.petId});

  @override
  State<AddDocuments> createState() => _AddDocumentsState();
}

class _AddDocumentsState extends State<AddDocuments> {
  //TextEditingController
  final TextEditingController _docNameController = TextEditingController();

  //to access the db functions
  final DocumentService _documentService = DocumentService();

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
        appBar: normalAppBar('Documents'),
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
                                  ? fileUpload('Upload file here')
                                  : GestureDetector(
                                      onTap: () {
                                        if (result != null) {
                                          final file = result!.files.first;
                                          openFile(file);
                                        }
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
              label('Document name'),
              Fields(
                  hint: "Enter the name of the document",
                  controller: _docNameController),
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
              Spacer(),
              FilledButton(
                  onPressed: () async {
                    if (_docNameController.text.isEmpty ||
                        filePath == null ||
                        filePath!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('Please Enter the neccessary details!')));
                      return;
                    } else {
                      final document = Documents(
                          dname: _docNameController.text,
                          did: DateTime.now().microsecond,
                          dfile: filePath ?? '',
                          didate: formattedIDate,
                          dedate: formattedEDate,
                          petID: widget.petId);
                      await _documentService
                          .updatedocument(document.did, document)
                          .then((_) {
                        _docNameController.clear();
                        setState(() {});
                        Navigator.pop(context, document);
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
