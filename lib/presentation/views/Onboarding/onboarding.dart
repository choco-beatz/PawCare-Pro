import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/user%20model/user.dart';
import 'package:pawcare_pro/presentation/views/emptydashboard/empty_dashboard.dart';
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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainBG,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: width),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 120,
                ),
                heading('Welcome'),
                oBSB,
                subject(
                    'Please enter your information below to get started.'),
                oBSB,
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
                              color: white,
                            ),
                          ),
                  ),
                  Positioned(
                    left: 115,
                    top: 130,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: white,
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
                oBSB,
                SizedBox(
                  height: 52,
                  width: 370,
                  child: TextFormField(
                    cursorColor: white,
                    style: const TextStyle(color: white, fontSize: 20),
                    decoration: fieldDecor(' Enter your name'),
                    controller: _usernameController,
                  ),
                ),
                Spacer(),
                FilledButton(
                    onPressed: () async {
                      if (_usernameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please Enter Your name to continue!')));
                        return;
                      } else {
                        final user = UserInfo(
                            username: _usernameController.text,
                            image: image ?? '',
                            id: DateTime.now().millisecond);
      
                        await _userInfoService.adduser(user);
                        _usernameController.clear();
      
                        //shared preference is initialized and a key and value is set
                        final SharedPreferences sP =
                            await SharedPreferences.getInstance();
                        sP.setString('username', user.username);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EmptyDash()));
                      }
                    },
                    style: mainButton,
                    child: const Text('Done'))
              ],
            ),
          ),
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
