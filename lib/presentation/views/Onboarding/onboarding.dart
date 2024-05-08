import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/presentation/views/EmptyDashboard/empty_dashboard.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBG,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 120,
            ),
            heading('Welcome'),
            sizedBox,
            subject('Please enter your information below to get started.'),
            sizedBox,
            Stack(clipBehavior: Clip.none, children: [
              const CircleAvatar(
                backgroundColor: grey,
                radius: 90,
                child: Icon(
                  size: 180,
                  Icons.account_circle_outlined,
                  color: Colors.white,
                ),
              ),
              Positioned(
                left: 115,
                top: 130,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        size: 25,
                        Icons.image_outlined,
                        color: mainColor,
                      )),
                ),
              )
            ]),
            sizedBox,
            SizedBox(
              height: 52,
              width: 370,
              child: TextFormField(
                  decoration: fieldDecor(' Enter your name')),
            ),
            const SizedBox(
              height: 100,
            ),
            FilledButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => EmptyDash()));
                },
                style: mainButton,
                child: const Text('Done'))
          ],
        ),
      ),
    );
  }
}
