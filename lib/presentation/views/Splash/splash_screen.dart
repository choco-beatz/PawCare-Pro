import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/presentation/views/Dashboard/dashboard.dart';
import 'package:pawcare_pro/presentation/views/EmptyDashboard/empty_dashboard.dart';
import 'package:pawcare_pro/presentation/views/Onboarding/onboarding.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Box<PetInfo?>? _petBox;

  final PetInfoService _petInfoService = PetInfoService();

  //for shared preference
  dynamic checkUsername;
  dynamic checkPetname;

  //check if the value for the key 'username' exist... if exist the value will be stored to checkUsername
  Future getValidation() async {
    final SharedPreferences sP = await SharedPreferences.getInstance();
    checkUsername = sP.getString('username');
    checkPetname = sP.getString('petname');

    setState(() {});
  }

  //to check if there is data present the box petinfo

  Future<int?> checkPet() async {
    await toInit();
    final pets = _petBox?.values.toList();
    if (pets != null) {
      for (var pet in pets) {
        if (pet!.isActive == true) {
          return pet.id;
        }
      }
    }
    return null;
  }

  //for animation
  AnimationController? controller;

  //to initialize the box before accessing
  Future<void> toInit() async {
    await _petInfoService.openBox();
  }

  @override
  void initState() {
    super.initState();

    //after the getValidation is completed actions for both the conditions are specified
    getValidation().whenComplete(() async {
      if (checkUsername == null) {
        controller = BottomSheet.createAnimationController(this);
        controller?.duration = Duration(seconds: 2);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          openBottomSheet(context);
        });
      } else {
        int? petId = await checkPet();
        if (petId != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Dashboard(
                        petID: petId,
                      )));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EmptyDash()));
        }
      }
      // else if (checkPetname == null && checkUsername != null) {
      //   print(checkPetname);
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => EmptyDash()));
      // }
      // else if (checkPetname != null && checkUsername != null) {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => Dashboard(
      //                 petID: pet!.id,
      //               )));
      // }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  openBottomSheet(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1), () {});
    showModalBottomSheet(
        transitionAnimationController: controller,
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
