import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/presentation/views/Onboarding/onboarding.dart';
import 'package:pawcare_pro/constant/style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      openBottomSheet(context);
    });
  }

  openBottomSheet(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), () {});
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: mainBG,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  top: -35,
                  left: 170,
                  child: CircleAvatar(
                    backgroundColor: mainBG,
                    radius: 40,
                    child: CircleAvatar(
                      backgroundColor: mainColor,
                      radius: 30,
                      child: CircleAvatar(
                        backgroundColor: mainBG,
                        foregroundColor: mainColor,
                        radius: 28,
                        child: Icon(
                          Icons.edit,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 65,
                      ),
                      heading('Personalized Pet Profiles'),
                      const SizedBox(
                        height: 25,
                      ),
                      subject(
                          'Create personalized profiles for each of your beloved pets on PawCare Pro. '),
                      const SizedBox(
                        height: 95,
                      ),
                      FilledButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Onboarding()));
                          },
                          style: mainButton,
                          child: Text('Get started'))
                    ],
                  ),
                )),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('asset/splash.jpg'), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
