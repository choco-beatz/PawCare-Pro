import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/domain/user%20model/user.dart';
import 'package:pawcare_pro/presentation/views/Splash/splash_screen.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';
import 'package:pawcare_pro/service/user_service.dart';

void main() async {
  //initializing hive
  await Hive.initFlutter();
  //getting the adapter that we created pet.g.dart
  Hive.registerAdapter(PetInfoAdapter());
  await PetInfoService().openBox();

  //getting the adapter that we created user.g.dart
  Hive.registerAdapter(UserInfoAdapter());
  await UserInfoService().openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: mainColor, focusColor: Colors.white),
      home: SplashScreen(),
    );
  }
}
