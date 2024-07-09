import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/certificate%20model/certificates.dart';
import 'package:pawcare_pro/presentation/views/healthcard/screens/certificate/add_certificates.dart';
import 'package:pawcare_pro/presentation/views/healthcard/screens/certificate/view_certificate.dart';

class EmptyCert extends StatelessWidget {
  final int petId;
  const EmptyCert({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: mainBG,
        body: Center(
            child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.only(right: 25, left: 25),
            child: Column(
              children: [
                SizedBox(
                  height: width > 600 ? height * 0.01 : height * 0.12,
                ),
                SizedBox(
                  height: width > 600 ? height * 0.6 : height * 0.25,
                  width: width * 0.5,
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
                Spacer(),
                OutlinedButton(
                    onPressed: () async {
                      final result = await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCertificates(petId: petId),
                        ),
                      );

                      if (result != null && result is Certificates) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewCertificates(petId: petId),
                          ),
                        );
                      }
                    },
                    style: dateButton,
                    child: subject('Add Certificate +'))
              ],
            ),
          ),
        )));
  }
}
