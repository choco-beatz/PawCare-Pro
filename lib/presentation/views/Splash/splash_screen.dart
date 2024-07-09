import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/presentation/views/dashboard/dashboard.dart';
import 'package:pawcare_pro/presentation/views/emptydashboard/empty_dashboard.dart';
import 'package:pawcare_pro/presentation/views/splash/widget/slidingpanel.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
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
    final pets = _petInfoService.petInfo?.values.toList();
    if (pets != null) {
      for (var pet in pets) {
        if (pet!.isActive) {
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
        controller?.duration = const Duration(seconds: 2);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // openBottomSheet(context);
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EmptyDash()));
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SlidingUpPanel(
        collapsed: Container(
          decoration: const BoxDecoration(
              color: mainBG,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
          child: const Center(
              child: FaIcon(
            FontAwesomeIcons.chevronUp,
            size: 40,
            color: white,
          )),
        ),
        maxHeight: height * 0.5,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        panel: const SlidingBox(),
        body: Center(
          child: width < 600
              ? Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/splash.jpg'),
                        fit: BoxFit.cover),
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/web_splash.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
        ),
      ),
    );
  }
}
