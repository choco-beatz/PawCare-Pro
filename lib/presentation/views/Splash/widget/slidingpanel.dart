import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/onboarding/onboarding.dart';
import 'package:pawcare_pro/presentation/views/splash/widget/box.dart';
import 'package:pawcare_pro/presentation/views/splash/widget/positionedicon.dart';

class SlidingBox extends StatelessWidget {
  const SlidingBox({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: splashBox,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: -35, left: width * 0.4, child: const PositionedIcon()),
          Positioned(
              child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                oBSB,
                space,
                heading('Personalized Pet Profiles'),
                const SizedBox(
                  height: 25,
                ),
                subject(
                    'Create personalized profiles for each of your beloved pets on PawCare Pro. '),
                const SizedBox(
                  height: 95,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Onboarding()));
                          },
                          style: mainButton,
                          child: const Text('Get started')),
                    ),
                  ],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
