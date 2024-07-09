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

class AddVaccines extends StatefulWidget {
  final int petId;
  const AddVaccines({super.key, required this.petId});

  @override
  State<AddVaccines> createState() => _AddVaccinesState();
}

class _AddVaccinesState extends State<AddVaccines> {
  //TextEditingControllers
  final TextEditingController _nameController = TextEditingController();

  final VaccineService _vaccineService = VaccineService();

  //for dates
  DateTime idate = DateTime.now();
  DateTime edate = DateTime.now();

  String formattedIDate = 'not set';
  String formattedEDate = 'not set';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: white,
        title: const Text(
          'Add Vaccines',
          style: TextStyle(fontSize: 18),
        ),
      ),
      backgroundColor: mainBG,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label('Schedule Vaccination'),
            SizedBox(
              height: 52,
              width: 370,
              child: TextFormField(
                style: const TextStyle(color: white, fontSize: 20),
                decoration: fieldDecor(" Enter the name of the Vaccination"),
                controller: _nameController,
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
                    print(formattedIDate);
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
            Spacer(),
            FilledButton(
                onPressed: () async {
                  if (_nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Please Enter the neccessary details!')));
                    return;
                  } else {
                    final vaccine = Vaccine(
                        name: _nameController.text,
                        id: DateTime.now().microsecond,
                        idate: formattedIDate ,
                        edate: formattedEDate,
                        petId: widget.petId);
        
                    await _vaccineService
                        .updateVaccine(vaccine.id, vaccine)
                        .then((_) {
                      _nameController.clear();
        
                      Navigator.pop(context, vaccine);
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
