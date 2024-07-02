import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/vaccine%20model/vaccine.dart';
import 'package:pawcare_pro/presentation/views/healthcard/screens/vaccines/add_vaccines.dart';
import 'package:pawcare_pro/presentation/views/healthcard/screens/vaccines/view_vaccines.dart';

class EmptyVaccine extends StatelessWidget {
  final int petId;
  const EmptyVaccine({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mainBG,
      body: Padding(
        padding: const EdgeInsets.only(right: 25, left: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.14,
              ),
              SizedBox(
                height: height * 0.20,
                width: width * 0.4,
                child: const Image(
                  fit: BoxFit.fill,
                  image: AssetImage('asset/vaccine.png'),
                ),
              ),
              space,
              space,
              space,
              heading('No vaccination added'),
              sizedBox,
              subject(
                  "Organize your pet's vaccinations effortlessly. Manage your pet's health seamlessly."),
              SizedBox(height: height * 0.15),
              OutlinedButton(
                  onPressed: () async {
                    final result = await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddVaccines(petId: petId),
                      ),
                    );

                    if (result != null && result is Vaccine) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewVaccines(petId: petId),
                        ),
                      );
                    }
                  },
                  style: dateButton,
                  child: subject('Add Vaccines +'))
            ],
          ),
        ),
      ),
    );
  }
}
