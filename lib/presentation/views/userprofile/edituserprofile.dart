import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/user%20model/user.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/presentation/views/widgets/normalappbar.dart';
import 'package:pawcare_pro/service/user_service.dart';

class EditUserProfile extends StatefulWidget {
  final int userIndex;
  final UserInfo user;
  const EditUserProfile(
      {super.key, required this.userIndex, required this.user});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  String? image;

  TextEditingController _usernameController = TextEditingController();

  final UserInfoService _userInfoService = UserInfoService();


  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    image = widget.user.image;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: normalAppBar('Edit User Profile'),
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
              Stack(clipBehavior: Clip.none, children: [
                CircleAvatar(
                  backgroundColor: grey,
                  radius: 95,
                  child: image!.isNotEmpty
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
                          id: widget.user.id);
                      log(user.username);
                      await _userInfoService.updateuser(
                          user, widget.userIndex);
                      setState(() {
                        widget.user.username = user.username;
                        widget.user.image = user.image;
                      });
                      _userInfoService.usersNotifier.value = await _userInfoService.getuser();
                      Navigator.pop(context, user);
                    }
                  },
                  style: mainButton,
                  child: const Text('Done'))
            ],
          ),
        ),
                  ),
                ));
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
