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
import 'package:pawcare_pro/domain/document%20model/document.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/service/document_services.dart';

class EditDocuments extends StatefulWidget {
  final int did;
  final int petId;
  const EditDocuments({super.key, required this.did, required this.petId});

  @override
  State<EditDocuments> createState() => _EditDocumentsState();
}

class _EditDocumentsState extends State<EditDocuments> {
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

  Documents? _doc;

  Future<void> _loadDoc() async {
    final document = await _documentService.getdocument(widget.did);
    if (document != null) {
      setState(() {
        _doc = document;
        _docNameController.text = _doc!.dname;

        filePath = _doc!.dfile;
        formattedEDate = _doc!.dedate;
        formattedIDate = _doc!.didate;
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
          'Edit Document',
          style: TextStyle(fontSize: 18),
        ),
      ),
      backgroundColor: mainBG,
      body: _doc == null
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
                    label('Document name'),
                    SizedBox(
                      height: 52,
                      width: 370,
                      child: TextFormField(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        decoration:
                            fieldDecor("Enter the name of the document"),
                        controller: _docNameController,
                        cursorColor: Colors.white,
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
                          if (_docNameController.text.isEmpty ||
                              filePath!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please Enter the neccessary details!')));
                            return;
                          } else {
                            final document = Documents(
                                dname: _docNameController.text,
                                did: _doc!.did,
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
