import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/user%20model/user.dart';
import 'package:pawcare_pro/presentation/views/EmptyDashboard/empty_dashboard.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  String? image;
  final TextEditingController _usernameController = TextEditingController();

  final UserInfoService _userInfoService = UserInfoService();

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
              CircleAvatar(
                backgroundColor: grey,
                radius: 95,
                child: image != null
                    ? CircleAvatar(
                        backgroundImage: FileImage(File(image ?? '')),
                        radius: 80,
                      )
                    : const CircleAvatar(
                        radius: 80,
                        backgroundColor: lightGrey,
                        child: Icon(
                          size: 65,
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
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
                      onPressed: () async {
                        getMainImagesFromGallery();
                      },
                      icon: const Icon(
                        size: 25,
                        Icons.image_outlined,
                        color: mainColor,
                      )),
                ),
              )
            ]),
            sizedBox,
            sizedBox,
            SizedBox(
              height: 52,
              width: 370,
              child: TextFormField(
                style: const TextStyle(color: Colors.white, fontSize: 20),
                decoration: fieldDecor(' Enter your name'),
                controller: _usernameController,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            FilledButton(
                onPressed: () async {
                  final user = UserInfo(
                    username: _usernameController.text,
                    image: image ?? '',
                  );

                  await _userInfoService.adduser(user);
                  _usernameController.clear();

                  //shared preference is initialized and a key and value is set
                  final SharedPreferences sP =
                      await SharedPreferences.getInstance();
                  sP.setString('username', user.username);
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

  Future getMainImagesFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000);
    XFile xfilePick = pickedFile!;

    setState(() {
      image = xfilePick.path;
    });
  }
}
