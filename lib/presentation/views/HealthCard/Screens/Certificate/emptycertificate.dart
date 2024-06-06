import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/healthcard/screens/certificate/add_certificates.dart';

class EmptyCert extends StatelessWidget {
  final int petId;
  const EmptyCert({super.key, required this.petId});

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
                  image: AssetImage('asset/certificate.png'),
                ),
              ),
              space,
              space,
              space,
              heading('No certificates added'),
              sizedBox,
              subject(
                  "Store certificates for complete care. Manage your pet's health seamlessly."),
              SizedBox(height: height * 0.15),
              OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCertificates(petId: petId,)));
                  },
                  style: dateButton,
                  child: subject('Add Certificate +'))
            ],
          ),
        ),
      ),
    );
  }
}
