import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/healthcard/Screens/Certificate/empty_certificate.dart';
import 'package:pawcare_pro/presentation/views/healthcard/Screens/Certificate/view_certificate.dart';
import 'package:pawcare_pro/presentation/views/healthcard/widgets/healthcard_dashboard_widgets.dart';

class HealthCardDashboard extends StatelessWidget {
  const HealthCardDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBG,
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: Colors.white,
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
              onTap: () {},
              child: HealthCardButton(
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
                        builder: (context) => ViewCertificates()));
              },
              child: HealthCardButton(
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
