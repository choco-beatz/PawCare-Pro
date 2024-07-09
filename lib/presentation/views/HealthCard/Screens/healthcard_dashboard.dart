import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/presentation/views/healthcard/Screens/Certificate/view_certificate.dart';
import 'package:pawcare_pro/presentation/views/healthcard/screens/vaccines/view_vaccines.dart';
import 'package:pawcare_pro/presentation/views/widgets/healthcard_dashboard_widgets.dart';

class HealthCardDashboard extends StatelessWidget {
  final int petId;
  const HealthCardDashboard({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBG,
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: white,
        title: const Text(
          'Health Card',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewVaccines(
                              petId: petId,
                            )));
              },
              child: CardButton(
                  bgColor: transgreen,
                  head: 'Vaccines',
                  image: 'asset/injection.png',
                  brColor: lightgreen),
            ),
            space,
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewCertificates(petId: petId)));
              },
              child: CardButton(
                  bgColor: transblue,
                  head: 'Certificates',
                  image: 'asset/docs.png',
                  brColor: lightBlue),
            )
          ],
        ),
      ),
    );
  }
}
