import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/domain/user%20model/user.dart';
import 'package:pawcare_pro/service/user_service.dart';

class Appbar extends StatefulWidget {
  final Color bg;
  Appbar({super.key, required this.bg});

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  final UserInfoService _userInfoService = UserInfoService();

  late ValueNotifier<List<UserInfo>> _usersNotifier;

  // //to store all the values that is fetched from db
  // List<UserInfo> _user = [];

  // //loading/fetching data from the hive
  // Future<void> _loadUsers() async {
  //   //the datas recived from the db is stored into list
  //   _user = await _userInfoService.getuser();
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    _usersNotifier = _userInfoService.usersNotifier;
    _userInfoService.openBox();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: double.infinity,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: ValueListenableBuilder<List<UserInfo>>(
        valueListenable: _usersNotifier,
        builder: (context, users, _) {
          if (users.isEmpty) {
            return const CircularProgressIndicator();
          } else {
            UserInfo user = users.first;
            return ListTile(
              title: const Text(
                'Hello,',
                style: TextStyle(
                    color: white, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              subtitle: Text(
                user.username,
                style: const TextStyle(
                    color: white, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              leading: user.image.isEmpty
                  ? const CircleAvatar(
                      radius: 30,
                      backgroundColor: white,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: mainBG,
                        child: FaIcon(
                          size: 30,
                          FontAwesomeIcons.user,
                          color: white,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 30,
                      backgroundColor: mainBG,
                      child: CircleAvatar(
                        backgroundImage: FileImage(File(user.image)),
                        radius: 80,
                      )),
            );
          }
        },
      ),
      backgroundColor: widget.bg,
      foregroundColor: white,
    );
  }
}
