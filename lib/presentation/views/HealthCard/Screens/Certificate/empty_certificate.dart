import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/add_pet/add_pet.dart';
import 'package:pawcare_pro/presentation/views/healthcard/Screens/Certificate/add_certificates.dart';

class EmptyCertificate extends StatelessWidget {
  const EmptyCertificate({super.key});

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
        padding: const EdgeInsets.only(right: 25, left: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 180,
            ),
            const SizedBox(
              height: 150,
              width: 150,
              child: Image(
                image: AssetImage('asset/story.png'),
              ),
            ),
            sizedBox,
            heading('No Certificates Added'),
            sizedBox,
            subject(
                "Store certificates for complete care. Manage your pet's health seamlessly."),
            const SizedBox(
              height: 160,
            ),
            FilledButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCertificates()));
                },
                style: secondaryButton,
                child: const Text('Add Certificates'))
          ],
        ),
      ),
    );
  }
}
