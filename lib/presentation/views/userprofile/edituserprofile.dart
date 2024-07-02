import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/user%20model/user.dart';
import 'package:pawcare_pro/presentation/views/emptydashboard/empty_dashboard.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  String? image;

  final TextEditingController _usernameController = TextEditingController();

  final UserInfoService _userInfoService = UserInfoService();

  late List<UserInfo?> _user;

  //loading/fetching data from the hive
  Future<void> _loadUser() async {
    //the datas recived from the db is stored
    _user = await _userInfoService.getuser();
    setState(() {
      _usernameController.text = _user.first!.username;
      image = _user.first!.image;
    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: Colors.white,
        title: const Text(
          'Edit User Profile',
          style: TextStyle(fontSize: 18),
        ),
      ),
      backgroundColor: mainBG,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 120,
              ),
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
              sizedBox,
              sizedBox,
              sizedBox,
              sizedBox,
              sizedBox,
              sizedBox,
              FilledButton(
                  onPressed: () async {
                    if (_usernameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('Please Enter Your name to continue!')));
                      return;
                    } else {
                      final user = UserInfo(
                          username: _usernameController.text,
                          image: image ?? '',
                          id: _user.first!.id);

                      await _userInfoService.updateuser(user, user.id);
                      _usernameController.clear();
                      if (mounted) {
                        _user.first = user;
                      }
                      Navigator.pop(context);
                    }
                  },
                  style: mainButton,
                  child: const Text('Done'))
            ],
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
