import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/AddPet/add_pet.dart';

import 'package:pawcare_pro/presentation/views/widgets/appbar.dart';

class EmptyDash extends StatelessWidget {
  const EmptyDash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: mainBG,
      body: Padding(
        padding: const EdgeInsets.only(right: 25, left: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const SizedBox(
              height: 150,
              width: 150,
              child: Image(
                image: AssetImage('asset/animals.png'),
              ),
            ),
            sizedBox,
            heading('Uh-Oh!'),
            sizedBox,
            subject(
                'Looks like you have no profiles set up at this moment, add your pet now'),
            const SizedBox(
              height: 110,
            ),
            FilledButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => AddPet()));
                },
                style: secondaryButton,
                child: const Text('Add your pets'))
          ],
        ),
      ),
    );
  }
}
