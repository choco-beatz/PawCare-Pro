import 'dart:core';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/vaccine%20model/vaccine.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/service/vaccine_services.dart';

class EditVaccine extends StatefulWidget {
  final int id;
  final int petId;
  const EditVaccine({super.key, required this.id, required this.petId});

  @override
  State<EditVaccine> createState() => _EditVaccineState();
}

class _EditVaccineState extends State<EditVaccine> {
  //TextEditingController
  final TextEditingController _vacNameController = TextEditingController();

  //to access the db functions
  final VaccineService _vaccineService = VaccineService();

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

  Vaccine? _vaccine;

  Future<void> _loadVac() async {
    final vac = await _vaccineService.getVaccine(widget.id);
    if (vac != null) {
      setState(() {
        _vaccine = vac;
        _vacNameController.text = _vaccine!.name;
        formattedEDate = _vaccine!.edate;
        formattedIDate = _vaccine!.idate;
      });
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _loadVac();

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
          'Edit Vaccine',
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
           
            label('Vaccine name'),
            SizedBox(
              height: 52,
              width: 370,
              child: TextFormField(
                style: const TextStyle(color: white, fontSize: 20),
                decoration: fieldDecor("Enter the name of the document"),
                controller: _vacNameController,
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
            Spacer(),
            FilledButton(
                onPressed: () async {
                  if (_vacNameController.text.isEmpty || filePath!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Please Enter the neccessary details!')));
                    return;
                  } else {
                    final vac = Vaccine(
                        name: _vacNameController.text,
                        id: _vaccine!.id,
                        idate: formattedIDate,
                        edate: formattedEDate,
                        petId: widget.petId);
                    await _vaccineService
                        .updateVaccine(vac.id, vac)
                        .then((_) {
                      _vacNameController.clear();
                      setState(() {});
                      Navigator.pop(context, vac);
                    });
                  }
                },
                style: mainButton,
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }

}
